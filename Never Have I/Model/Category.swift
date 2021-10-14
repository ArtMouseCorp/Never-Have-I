import UIKit

struct Category: Codable {
    public let id: Int
    public let name: String
    public let tasks: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, tasks
    }
    
    public static func parse() -> [Category]? {
        let jsonData = readLocalJSONFile(forName: "categories_\(State.shared.getLanguage().rawValue)")!
        do {
            let decodedData = try JSONDecoder().decode(Category.Response.self, from: jsonData)
            return decodedData.categories
            } catch {
                print("error: \(error)")
            }
            return nil
    }
    
    public static var categories: [Category] = []
    
    public static func updateCategories() {
        self.categories = parse() ?? []
    }
    
    public static let defaultCategory = Category(id: 0, name: "", tasks: [])
    
    struct Response: Codable {
        let categories: [Category]
    }
}


