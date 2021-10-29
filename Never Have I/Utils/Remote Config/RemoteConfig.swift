import Foundation
import FirebaseRemoteConfig
import SwiftyJSON

enum RCValueKey: String {
    case subscriptionPage = "sub_page"
    
    internal enum SubscriptionPage: String {
        case title
        case reasons
        case subtitle
        case priceTitle
        case buttonTitle
        case showCloseButton
        case closeButtonDelay
        case freeCards
        case productId
    }

}

class RCValues {
    
    static let sharedInstance = RCValues()
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            RCValueKey.subscriptionPage.rawValue: SubscriptionPage.default,
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Don't actually do this in production!
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        // 1
        activateDebugMode()
        
        // 2
        RemoteConfig.remoteConfig().fetch { _, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                // In a real app, you would probably want to call the loading
                // done callback anyway, and just proceed with the default values.
                // I won't do that here, so we can call attention
                // to the fact that Remote Config isn't loading.
                return
            }
            
            // 3
            RemoteConfig.remoteConfig().activate { _, _ in
                print("Retrieved values from the cloud!")
            }
        }
    }
    
    func subscriptionPage() -> SubscriptionPage {
        
        let lang = State.shared.getLanguageCode().rawValue
        
        let key = RCValueKey.subscriptionPage.rawValue
        
        guard let value = RemoteConfig.remoteConfig()["\(key)_\(lang)"].jsonValue else {
            return SubscriptionPage.default
        }
        
        let json = JSON(value)
        
        let subPage = SubscriptionPage(
            title:              json[RCValueKey.SubscriptionPage.title.rawValue].stringValue,
            reasons:            json[RCValueKey.SubscriptionPage.reasons.rawValue].arrayObject as! [String],
            subtitle:           json[RCValueKey.SubscriptionPage.subtitle.rawValue].stringValue,
            priceTitle:         json[RCValueKey.SubscriptionPage.priceTitle.rawValue].stringValue,
            buttonTitle:        json[RCValueKey.SubscriptionPage.buttonTitle.rawValue].stringValue,
            showCloseButton:    json[RCValueKey.SubscriptionPage.showCloseButton.rawValue].boolValue,
            closeButtonDelay:   json[RCValueKey.SubscriptionPage.closeButtonDelay.rawValue].intValue,
            freeCards:          json[RCValueKey.SubscriptionPage.freeCards.rawValue].intValue,
            productId:          json[RCValueKey.SubscriptionPage.productId.rawValue].stringValue
        )
        
        return subPage
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
