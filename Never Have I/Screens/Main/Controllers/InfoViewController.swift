import UIKit

class InfoViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    
    // Text Views
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Variables
    
    internal enum Content {
        case terms, privacy
    }
    
    var contentType: Content = .privacy
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hapticFeedback()
    }
    
    // MARK: - Custom functions
    
    override func configureUI() {
        
        switch contentType {
        case .terms:
            titleLabel.text = localized("button.settings.termsOfUse")
            self.styleInfoText(Config.TERMS)
            
        case .privacy:
            titleLabel.text = localized("button.settings.privacyPolicy")
            self.styleInfoText(Config.PRIVACY)
        }
        
    }
    
    public func initialize(for content: Content) {
        self.contentType = content
    }
    
    private func styleInfoText(_ string: String) {
        
        var text = string
        var titles: [String] = []
        
        while let title = text.slice(from: "<h>", to: "</h>") {
            
            titles.append(title)
            let openRange = text.range(of: "<h>")!
            text = text
                .replacingOccurrences(of: "<h>", with: "", range: openRange)
            
        }
        
        text = text
            .replacingOccurrences(of: "<h>", with: "")
            .replacingOccurrences(of: "</h>", with: "")
        
        let attributedString = NSMutableAttributedString(string: text)
        
        let textRange = NSRange(text.range(of: text)!, in: text)
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.white
        ]
        
        attributedString.setAttributes(textAttributes, range: textRange)
        
        titles.forEach { title in
            let range = NSRange(text.range(of: title)!, in: text)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                .foregroundColor: UIColor.white
            ]
            
            attributedString.setAttributes(attributes, range: range)
            
        }

        self.textView.attributedText = attributedString
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
