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
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        languageLabel.localize(with: "settings.language", defaultValue: "LANGUAGE")
        termsOfUseLabel.localize(with: "settings.termsOfUse", defaultValue: "TERMS OF USE")
        privacyPolicyLabel.localize(with: "settings.privacyPolicy", defaultValue: "PRIVACY POLICY")
        restorePurchasesLabel.localize(with: "settings.restorePurchases", defaultValue: "RESOTRE PURCHASES")
        languageImageView.image = Language.languages.first { $0.code == State.shared.getLanguage() }?.image
    }
    
    private func setupGestures() {
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
        // TODO: - Present terms of use popup
        let infoViewController = InfoViewController.load(from: Main.info)
        infoViewController.titleLabelText = getLocalizedString(for: "settings.termsOfUse", defaultValue: "TERMS OF USE")
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    @objc func privacyPolicyViewTapped() {
        // TODO: - present privacy policy popup
        let infoViewController = InfoViewController.load(from: Main.info)
        infoViewController.titleLabelText = getLocalizedString(for: "settings.privacyPolicy", defaultValue: "PRIVACY POLICY")
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    @objc func restorePurchasesTapped() {
        // TODO: - resotre purchases

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
