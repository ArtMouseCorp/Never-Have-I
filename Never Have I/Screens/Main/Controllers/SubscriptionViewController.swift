import UIKit
import StoreKit

class SubscriptionViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet var dotViews: [UIView]!
    
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
        
    // Image Views
    @IBOutlet weak var logoImageView: UIImageView!
    
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
    
    override func setupGestures() {
        let logoTap = UITapGestureRecognizer(target: self, action: #selector(handleCodeRedemption))
        logoTap.numberOfTapsRequired = 3
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(logoTap)
        
//        let thirdDotTap = UITapGestureRecognizer(target: self, action: #selector(handlePromotionalOffer))
//        thirdDotTap.numberOfTapsRequired = 6
//        dotViews[2].isUserInteractionEnabled = true
//        dotViews[2].addGestureRecognizer(thirdDotTap)
    }
    
    private func configureDots() {
        for dotView in dotViews {
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
                self.onCloseButtonPressed()
                self.dismiss(animated: true)
            }
            return
        }
        
        let productId = pageConfig.productId
        
        StoreManager.getProducts(for: [productId]) { products in
            
            guard let product = products.first else {
                self.onCloseButtonPressed()
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
    
    // MARK: - Gesture actions
    
    @objc private func handleCodeRedemption() {
        if #available(iOS 14.0, *) {
            SKPaymentQueue().presentCodeRedemptionSheet()
        }
    }
    
    @objc private func handlePromotionalOffer() {
        
        guard let product = product else { return }
        
        guard isConnectedToNetwork() else {
            self.showNetworkConnectionAlert()
            return
        }
        
        StoreManager.purchasePromo(product, promoId: pageConfig.promotionalOfferId) {
            self.dismiss(animated: true)
        }
        
    }
        
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        onCloseButtonPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startFreeTrialButtonPressed(_ sender: Any) {
        
        guard let product = product else {
            self.onCloseButtonPressed()
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
        
        StoreManager.restore { isSubscribed, isRestored in
            
            if isSubscribed {
                self.showAlreadySubscribedAlert() {
                    StoreManager.updateStatus()
                    self.dismiss(animated: true)
                }
                return
            }
            
            if isRestored {
                self.showRestoredAlert() {
                    self.dismiss(animated: true)
                }
                return
            }
            
            if !isRestored {
                self.showNotSubscriberAlert()
                return
            }
            
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
