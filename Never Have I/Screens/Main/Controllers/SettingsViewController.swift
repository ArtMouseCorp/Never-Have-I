import UIKit

class SettingsViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var languageView: NHEButtonView!
    @IBOutlet weak var termsOfUseView: NHEButtonView!
    @IBOutlet weak var privacyPolicyView: NHEButtonView!
    @IBOutlet weak var restorePurchasesView: NHEButtonView!
    
    // Labels
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var termsOfUseLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var restorePurchasesLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    
    // Image Views
    @IBOutlet weak var languageImageView: UIImageView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        languageLabel.localize(with: "button.settings.language")
        termsOfUseLabel.localize(with: "button.settings.termsOfUse")
        privacyPolicyLabel.localize(with: "button.settings.privacyPolicy")
        restorePurchasesLabel.localize(with: "button.settings.restorePurchases")
        languageImageView.image = State.shared.getLanguageCode().getLanguage().image
    }
    
    override func configureUI() {
    }
    
    override func setupGestures() {
        languageView.addTapGesture(target: self, action: #selector(languageViewTapped))
        termsOfUseView.addTapGesture(target: self, action: #selector(termsOfUseViewTapped))
        privacyPolicyView.addTapGesture(target: self, action: #selector(privacyPolicyViewTapped))
        restorePurchasesView.addTapGesture(target: self, action: #selector(restorePurchasesTapped))
    }
    
    // MARK: - Gesture actions
    
    @objc func languageViewTapped() {
        // TODO: - Present Language popup
        let languageViewController = LanguagePopupViewController.load(from: Popup.language)
        languageViewController.onSelection = {
            self.localize()
        }
        showPopup(languageViewController)
    }
    
    @objc func termsOfUseViewTapped() {
        let infoViewController = InfoViewController.load(from: Main.info)
        infoViewController.titleLabelText = localized("button.settings.termsOfUse")
        self.present(infoViewController, animated: true)
    }
    
    @objc func privacyPolicyViewTapped() {
        let infoViewController = InfoViewController.load(from: Main.info)
        infoViewController.titleLabelText = localized("button.settings.privacyPolicy")
        self.present(infoViewController, animated: true)
    }
    
    @objc func restorePurchasesTapped() {

        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        StoreManager.restore {
            self.dismiss(animated: true)
        }
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
