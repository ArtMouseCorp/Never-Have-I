import Foundation

struct SubscriptionPage: Codable {
    
    let title: String
    let reasons: [String]
    let subtitle: String
    let priceTitle: String
    let buttonTitle: String
    let showCloseButton: Bool
    let closeButtonDelay: Int
    let freeCards: Int
    let productId: String
    
    public static let `default` = SubscriptionPage(
        title: "NEVER HAVE I EVER",
        reasons: [
            "HAD ACCESS TO MORE THAN 1200 CARDS",
            "HAD MORE FUN",
            "HAD ACCESS TO THE BEST NEVER HAVE I EVER APP"
        ],
        subtitle: "NOW YOU CAN HAVE ALL THIS",
        priceTitle: "FREE FOR %trial_period%\nthen %subscription_price% PER %subscription_period%",
        buttonTitle: "START FREE TRIAL",
        showCloseButton: true,
        closeButtonDelay: 2,
        freeCards: 2,
        productId: "com.ua.artmouse.neverhavei.week"
 
    )
    
    public func loadFromJson(completion: ((SubscriptionPage) -> ())) {
        
        let jsonData = readLocalJSONFile(forName: "subscriptionPage_\(State.shared.getLanguageCode().rawValue)")!
        do {
            let config = try JSONDecoder().decode(SubscriptionPage.self, from: jsonData)
            completion(config)
            print("Subsctiption config loaded from json file")
            
        } catch {
            print("-------------------------")
            print("Error from json decoding of subscription config:")
            print(error)
            print(error.localizedDescription)
            print("-------------------------")
        }
        
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
