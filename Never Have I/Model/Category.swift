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
        self.loadFromJson() {
            completion()
        }
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
            completion()
        } catch {
            self.all = []
            completion()
            
        }
        
    }
    
}


