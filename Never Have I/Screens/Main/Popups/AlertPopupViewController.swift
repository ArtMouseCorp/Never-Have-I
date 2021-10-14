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
    var onMainButtonPressed: (()->()) = {}
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleLabelText
        descriptionLabel.text = descriptionLabelText
        mainButon.setTitle(mainButtonText, for: .normal)
        
        animateIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        alertView.roundCorners(radius: 18, corners: .allCorners)
        alertView.setBorder(width: 2, color: .white)
        mainButon.roundCorners(radius: 12, corners: .allCorners)
    }
    
    func animateIn() {
        alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)

        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.alertView.transform = .identity
        }
    }
    
    func animateOut() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
        } completion: { completed in
            self.view.removeFromSuperview()
        }
    }
        
    // MARK: - @IBActions
    
    @IBAction func mainButtonPressed(_ sender: Any) {
        onMainButtonPressed()
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
