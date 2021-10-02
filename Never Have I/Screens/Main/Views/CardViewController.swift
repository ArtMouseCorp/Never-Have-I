import UIKit

class CardViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Variables
    var titleLabelText = ""
    var descriptionLabelText = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
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
