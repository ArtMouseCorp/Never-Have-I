import UIKit

class CardViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Variables
    
    var descriptionLabelText = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.localize(with: "cards.nhie", defaultValue: "NEVER HAVE I EVER")
        descriptionLabel.text = descriptionLabelText
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
