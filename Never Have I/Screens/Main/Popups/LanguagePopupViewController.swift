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
    
    let languageNames = ["ENGLISH", "РУССКИЙ", "FRANÇAIS", "DEUTSCH"]
    var selectedItem = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        configure(tableView)
        backgroundView.roundCorners(radius: 18, corners: .allCorners)
        selectButton.roundCorners(radius: 12, corners: .allCorners)
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
    
    private func setupGestures() {
        
    }
    
    // MARK: - Gesture actions
    
    // MARK: - @IBActions
    @IBAction func selectButtonPressed(_ sender: Any) {
        animateOut()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        animateOut()
    }
    
}

extension LanguagePopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.languageCell.id, for: indexPath) as! LanguageTableViewCell
        
        cell.titleLabel.text = languageNames[indexPath.row]
        
        selectedItem == indexPath.row ? cell.setChecked() : cell.setUnchecked()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedItem = indexPath.row
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
