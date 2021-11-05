import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    public static let appLaunchCount: String            = "appLaunchCount"
    public static let language: String                  = "language"
    public static let isCustomLanguageChange: String    = "isCustomLanguageChange"
}

public var safeAreaBottomInset: CGFloat {
    let window = UIApplication.shared.windows.first
    let bottomPadding = window!.safeAreaInsets.bottom
    return bottomPadding
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
