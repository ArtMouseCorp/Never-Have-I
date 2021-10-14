import UIKit

extension UIButton {

    public func localize(with key: String, defaultValue: String) {
        self.setTitle(getLocalizedString(for: key, defaultValue: defaultValue), for: .normal)
    }
    
    func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
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
