import UIKit

class LanguageTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        cellBackgroundView.roundCorners(radius: 12, corners: .allCorners)
        addShadow()
    }
    
    private func addShadow() {
        cellBackgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.layer.shadowRadius = 4
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setUnchecked() {
        cellBackgroundView.layer.shadowOpacity = 0
        cellBackgroundView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.3)
    }
    
    func setChecked() {
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
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
