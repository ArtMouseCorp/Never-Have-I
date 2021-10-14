import UIKit

class SubscriptionViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet var dotsView: [UIView]!
    
    // Labels
    @IBOutlet weak var neverHaveILabel: UILabel!
    @IBOutlet weak var firstOfferLabel: UILabel!
    @IBOutlet weak var secondOfferLabel: UILabel!
    @IBOutlet weak var thirdOfferLabel: UILabel!
    @IBOutlet weak var hadAccessLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cancelAnytimeLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var startFreeTrialButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
        
    // MARK: - Variables
    
    var onCloseButtonPressed: (()->()) = {}
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        configureDots()
        configureButton()
    }
    
    private func configureDots() {
        for dotView in dotsView {
            dotView.capsuleCorners()
        }
    }
    
    private func configureButton() {
        startFreeTrialButton.roundCorners(radius: 12, corners: .allCorners)
        startFreeTrialButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        startFreeTrialButton.layer.shadowOpacity = 1
        startFreeTrialButton.layer.shadowRadius = 4
        startFreeTrialButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
        
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        onCloseButtonPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startFreeTrialButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restorePurchasesButtonPressed(_ sender: Any) {
        // TODO: - RESTORE PURCHASES
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
