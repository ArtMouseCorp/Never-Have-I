import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    static let appLaunchCount: String = "appLaunchCount"
    static let language: String = "language"
}

public var safeAreaBottomInset: CGFloat {
    let window = UIApplication.shared.windows.first
    let bottomPadding = window!.safeAreaInsets.bottom
    return bottomPadding
}

public func getLocalizedString(for key: String, defaultValue: String) -> String {
    let path = Bundle.main.path(forResource: State.shared.getLanguage().rawValue, ofType: "lproj")
    let bundle = Bundle(path: path!)
    return bundle!.localizedString(forKey: key, value: defaultValue, table: nil)
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
