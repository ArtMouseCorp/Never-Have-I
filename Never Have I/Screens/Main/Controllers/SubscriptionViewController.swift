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
    
    var pageConfig: SubscriptionPage = .default
    var product: StoreManager.Product?
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageConfig = RCValues.sharedInstance.subscriptionPage()
        self.getProducts()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        restorePurchasesButton.localize(with: "button.subscription.restore")
        cancelAnytimeLabel.localize(with: "subscription.cancelInfo")
    }
    
    override func configureUI() {
        configureDots()
        configureButton()
        
        neverHaveILabel.text = pageConfig.title
        firstOfferLabel.text = pageConfig.reasons[0]
        secondOfferLabel.text = pageConfig.reasons[1]
        thirdOfferLabel.text = pageConfig.reasons[2]
        hadAccessLabel.text = pageConfig.subtitle
        
    }
    
    private func configureDots() {
        for dotView in dotsView {
            dotView.capsuleCorners()
        }
    }
    
    private func configureButton() {
        startFreeTrialButton.roundCorners(radius: 12)
        startFreeTrialButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        startFreeTrialButton.layer.shadowOpacity = 1
        startFreeTrialButton.layer.shadowRadius = 4
        startFreeTrialButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func getProducts() {
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert() {
                self.dismiss(animated: true)
            }
            return
        }
        
        let productId = pageConfig.productId
        
        StoreManager.getProducts(for: [productId]) { products in
            
            guard let product = products.first else {
                self.dismiss(animated: true)
                return
            }
            
            self.product = product
            
            DispatchQueue.main.async {
                self.loadSubscriptionPrice()
            }
            
        }
        
    }
    
    private func loadSubscriptionPrice() {
        
        guard let product = product else { return }
        
        if let trialPeriod = product.trialPeriod {
            self.priceLabel.text = pageConfig.priceTitle
                .replacingOccurrences(of: "%trial_period%", with: trialPeriod)
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
        } else {
            self.priceLabel.text = pageConfig.priceTitle
                .replacingOccurrences(of: "%subscription_price%", with: product.price)
                .replacingOccurrences(of: "%subscription_period%", with: product.subscriptionPeriod)
        }
        
    }
        
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        onCloseButtonPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startFreeTrialButtonPressed(_ sender: Any) {
        
        print("Subscribe")
        
        guard let product = product else {
            self.dismiss(animated: true)
            return
        }
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        StoreManager.purchase(product) {
            self.dismiss(animated: true)
        }
        
    }
    
    @IBAction func restorePurchasesButtonPressed(_ sender: Any) {
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        StoreManager.restore {
            self.dismiss(animated: true)
        }
        
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
