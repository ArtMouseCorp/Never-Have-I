import UIKit

class AlertPopupViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var alertView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var mainButon: UIButton!
    
    // MARK: - Variables
    
    var titleLabelText = ""
    var descriptionLabelText = ""
    var mainButtonText = "OK"
    var onMainButtonPress: (() -> ()) = { }
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleLabelText
        descriptionLabel.text = descriptionLabelText
        mainButon.setTitle(mainButtonText, for: .normal)
        
        animateIn()
    }

    // MARK: - Custom functions
    
    override func configureUI() {
        alertView.roundCorners(radius: 18)
        alertView.setBorder(width: 2, color: .white)
        mainButon.roundCorners(radius: 12)
    }
    
    public func initialize(title: String, message: String) {
        self.titleLabelText = title
        self.descriptionLabelText = message
    }
    
    func animateIn() {
        alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.alertView.transform = .identity
        }
    }
    
    func animateOut() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
        } completion: { completed in
            self.view.removeFromSuperview()
        }
    }
        
    // MARK: - @IBActions
    
    @IBAction func mainButtonPressed(_ sender: Any) {
        onMainButtonPress()
        animateOut()
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
