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
             ru = "ru",
             fr = "fr",
             de = "de"
        
        init(_ value: String) {
            switch value.lowercased() {
            case "en": self = .en
            case "ru", "ua": self = .ru
            case "fr": self = .fr
            case "de": self = .de
            default: self = .en
            }
        }
    }
    
    public static func getLang(code: Code) -> Language {
        return languages.first { lang in
            lang.code == code
        }!
    }
    
    public static var languages = [
        Language(name: "ENGLISH",   image: UIImage(named: "UK")!,        code: Code.en),
        Language(name: "РУССКИЙ",   image: UIImage(named: "Russia")!,    code: Code.ru),
        Language(name: "FRANÇAIS",  image: UIImage(named: "France")!,    code: Code.fr),
        Language(name: "DEUTSCH",   image: UIImage(named: "Germany")!,   code: Code.de)
    ]
}
