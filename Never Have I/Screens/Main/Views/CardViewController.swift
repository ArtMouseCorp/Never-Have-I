import UIKit

class CardViewController: UIViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Variables
    
    var titleLabelText: String = ""
    var descriptionLabelText: String = ""
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        descriptionLabel.text = descriptionLabelText
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        self.view.roundCorners(radius: 18)
        self.view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.view.layer.shadowOpacity = 1
        self.view.layer.shadowRadius = 4
        self.view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public func initialize(with task: String) {
        
        let array = task.split(separator: ")", maxSplits: 1)
        
        var title = String(array[0])
        title.removeFirst()
        var description = String(array[1])
        description.removeFirst()
        
        titleLabelText = title.uppercased()
        descriptionLabelText = description.uppercased()
        
        self.configureUI()
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
