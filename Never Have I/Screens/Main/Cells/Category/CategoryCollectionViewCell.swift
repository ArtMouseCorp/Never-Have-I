import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryIndicatorImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryBackgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        categoryBackgroundImageView.layer.cornerRadius = 18
    }
}
