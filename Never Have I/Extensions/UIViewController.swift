import UIKit

extension UIViewController {
    
    public static func load(from screen: StoryboardScreen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.id) as! Self
    }
    
    func showPopup(_ popup: UIViewController) {
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    
    public func showAlreadySubscribedAlert(completion: (() -> ())? = nil) {
        let alert = AlertPopupViewController.load(from: Popup.alert)
        alert.initialize(title: localized("alert.subscribed.title"), message: localized("alert.subscribed.message"))
        alert.onMainButtonPress = {
            completion?() ?? ()
        }
        self.showPopup(alert)
    }
    
    public func showRestoredAlert(completion: (() -> ())? = nil) {
        let alert = AlertPopupViewController.load(from: Popup.alert)
        alert.initialize(title: localized("alert.restored.title"), message: localized("alert.restored.message"))
        alert.onMainButtonPress = {
            completion?() ?? ()
        }
        self.showPopup(alert)
    }
    
    public func showNotSubscriberAlert(completion: (() -> ())? = nil) {
        let alert = AlertPopupViewController.load(from: Popup.alert)
        alert.initialize(title: localized("alert.notSubscriber.title"), message: localized("alert.notSubscriber.message"))
        alert.onMainButtonPress = {
            completion?() ?? ()
        }
        self.showPopup(alert)
    }
    
    public func showNetworkConnectionAlert(completion: (() -> ())? = nil) {
        let alert = AlertPopupViewController.load(from: Popup.alert)
        alert.initialize(title: localized("alert.noConnection.title"), message: localized("alert.noConnection.message"))
        alert.onMainButtonPress = {
            completion?() ?? ()
        }
        self.showPopup(alert)
    }
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: localized("alert.loader.message"), preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader(completion: (() -> ())? = nil) {
        dismiss(animated: false, completion: completion)
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
