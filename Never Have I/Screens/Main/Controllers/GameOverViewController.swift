import UIKit
import StoreKit

class GameOverViewController: BaseViewController {

    // MARK: - @IBOutlets
        
    // Labels
    @IBOutlet weak var playMoreLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var rateUsButton: UIButton!
    
    // MARK: - Variables
    
    var onPlayAgainButtonPressed: (()->()) = {}
        
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        playMoreLabel.localize(with: "gameover.playMoreCards", defaultValue: "PLAY MORE CARDS IN OTHER CATEGORIES")
        playAgainButton.localize(with: "gameover.playAgain", defaultValue: "PLAY AGAIN")
        rateUsButton.localize(with: "gameover.rateUs", defaultValue: "RATE US")
    }
    
    private func configureUI() {
        playAgainButton.roundCorners(radius: 12, corners: .allCorners)
        addButtonShadow()
    }
    
    func addButtonShadow() {
        playAgainButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        playAgainButton.layer.shadowOpacity = 1
        playAgainButton.layer.shadowRadius = 4
        playAgainButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
        
    // MARK: - @IBActions
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        onPlayAgainButtonPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateUsButtonPressed(_ sender: Any) {
        SKStoreReviewController.requestReview()
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
