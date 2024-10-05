import UIKit

extension UIButton {

    public func localize(with key: String) {
        self.setTitle(localized(key), for: .normal)
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
