import UIKit

struct Category: Codable, Equatable {
    
    public let id: Int
    public let name: String
    public let tasks: [String]
    
    public enum CodingKeys: String, CodingKey {
        case id, name, tasks
    }
    
    public static var all: [Category] = []
    
    public static func get(completion: @escaping (() -> ())) {
        
        self.all.removeAll()
        
        //        DatabaseManager.shared.getCategories { result in
        //
        //            switch result {
        //
        //            case .success(let categories):
        //
//                        print("------------------------------------------------------")
//                        print("Successfuly decoded categories from Firebase Database:")
//                        print(categories)
//                        print("------------------------------------------------------")
        //
        //                self.all = categories
        //                completion()
        //
        //            case .failure(let databaseError):
        //
        //                print("-------------------------------------------------")
        //                print("Error decoding categories from Firebase Database:")
        //                print(databaseError.error as Any)
        //                print(databaseError.description)
        //                print("-------------------------------------------------")
        //
        self.loadFromJson() {
            completion()
        }
        //            }
        
        //        }
        
    }
    
    private static func loadFromJson(completion: @escaping (() -> ())) {
        
        guard let jsonData = readLocalJSONFile(forName: "categories_\(State.shared.getLanguageCode().rawValue)") else {
            self.all = []
            completion()
            return
        }
        
        do {
            
            let categories = try JSONDecoder().decode([Category].self, from: jsonData)
            self.all = categories
            
            print("--------------------------------------------------------")
            print("Successfuly decoded categories from the local json file:")
            print("--------------------------------------------------------")
            
            completion()
            
        } catch {
            
            print("-----------------------------------------------")
            print("Error decoding categories from local json file:")
            print(error)
            print(error.localizedDescription)
            print("-----------------------------------------------")
            
            self.all = []
            completion()
            
        }
        
    }
    
}


