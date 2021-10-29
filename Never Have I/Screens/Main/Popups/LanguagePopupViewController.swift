import UIKit

class LanguagePopupViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var backgroundView: UIView!
    
    // Labels
    @IBOutlet weak var languageLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
        
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var selectedItem = 0
    var onSelection: (()->()) = {}
    var lastSelectedLanguage: Language.Code = .en
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIn()
        lastSelectedLanguage = State.shared.getLanguageCode()
        super.hapticFeedback()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        languageLabel.localize(with: "button.settings.language")
        selectButton.setTitleWithoutAnimation(title: localized("button.language.select"))
        cancelButton.setTitleWithoutAnimation(title: localized("button.language.cancel"))
    }
    
    override func configureUI() {
        configure(tableView)
        backgroundView.roundCorners(radius: 18)
        selectButton.roundCorners(radius: 12)
        tableViewHeightConstraint.constant = tableView.contentHeight
        addButtonShadow()
    }
    
    func addButtonShadow() {
        selectButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        selectButton.layer.shadowOpacity = 1
        selectButton.layer.shadowRadius = 4
        selectButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func animateIn() {
        backgroundView.transform = CGAffineTransform(translationX: 400, y: 0)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.backgroundView.transform = .identity
        }
    }
    
    func animateOut() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.backgroundView.transform = CGAffineTransform(translationX: 400, y: 0)
        } completion: { completed in
            self.view.removeFromSuperview()
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        onSelection()
        animateOut()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        State.shared.setLanguage(to: lastSelectedLanguage)
        animateOut()
    }
    
}

extension LanguagePopupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.languageCell.id, for: indexPath) as! LanguageTableViewCell
        
        cell.titleLabel.text = Language.languages[indexPath.row].name
        let index = Language.languages.firstIndex{ $0.code == State.shared.getLanguageCode() }
        index == indexPath.row ? cell.setChecked() : cell.setUnchecked()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        State.shared.setLanguage(to: Language.languages[indexPath.row].code)
        localize()
        tableView.reloadData()
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
