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
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
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
        showPopup(languageViewController)
    }
    
    @objc func termsOfUseViewTapped() {
        // TODO: - Present terms of use popup
    }
    
    @objc func privacyPolicyViewTapped() {
        // TODO: - present privacy policy popup
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
