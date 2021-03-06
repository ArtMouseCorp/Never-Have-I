import UIKit

public enum Main: String, StoryboardScreen {
    
    case navigation     = "UINavigationController"
    case category       = "CategoryViewController"
    case settings       = "SettingsViewController"
    case task           = "TaskViewController"
    case card           = "CardViewController"
    case gameover       = "GameOverViewController"
    case subscription   = "SubscriptionViewController"
    case info           = "InfoViewController"
    
}

extension Main {
    
    public var location: Storyboard { return .Main }
    public var id: String { return self.rawValue }
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: self.location.rawValue, bundle: nil)
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
