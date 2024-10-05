import UIKit

struct Language {
    
    var name: String
    var image: UIImage
    let code: Code
    
    init(name: String, image: UIImage, code: Code) {
        self.name = name
        self.image = image
        self.code = code
    }
    
    public enum Code: String, Codable {
        case en = "en",
             fr = "fr",
             de = "de"
        
        init(_ value: String) {
            switch value.lowercased() {
            case "en": self = .en
            case "fr": self = .fr
            case "de": self = .de
            default: self = .en
            }
        }
        
        public func getLanguage() -> Language {
            return (Language.languages.first { $0.code == self })!
        }
        
    }
    
    public static var languages = [
        Language(name: "ENGLISH",       image: UIImage(named: "UK")!,        code: Code.en),
        Language(name: "FRANÇAIS",      image: UIImage(named: "France")!,    code: Code.fr),
        Language(name: "DEUTSCH",       image: UIImage(named: "Germany")!,   code: Code.de)
    ]
    
}
