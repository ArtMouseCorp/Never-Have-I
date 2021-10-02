import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var checkmarkView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        checkmarkView.capsuleCorners()
    }
    
    // MARK: - @IBActions
    
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
