import Foundation
import FirebaseDatabase

struct DatabaseManager {
    
    public static let shared: DatabaseManager = DatabaseManager()
    
    private let ref = Database.database().reference()
    
    public func getCategories(completion: @escaping (Result<[Category], DatabaseError>) -> Void) {
        
        ref.child("categories_\(State.shared.getLanguageCode().rawValue)").getData { error, dataSnapshot in
            
            if let error = error {
                completion(.failure(DatabaseError(error: error, description: error.localizedDescription)))
                return
            }
            
            
            guard let array = dataSnapshot.value as? NSArray else {
                completion(.failure(DatabaseError(error: nil, description: "Not an array")))
                return
            }
            
            var categories: [Category] = []
            
            for element in array {
                
                guard let categoryDict = element as? NSDictionary else {
                    completion(.failure(DatabaseError(error: nil, description: "Not a dictionary")))
                    return
                }
                
                let category = Category(
                    id: categoryDict["id"] as? Int ?? 0,
                    name: categoryDict["name"] as? String ?? "",
                    tasks: categoryDict["tasks"] as? [String] ?? []
                )
                
                categories.append(category)
                
                completion(.success(categories))
            }
        }
    }
    
    
    internal struct DatabaseError: Error {
        let error: Error?
        let description: String
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
