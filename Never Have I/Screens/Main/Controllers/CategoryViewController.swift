import UIKit

class CategoryViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var playView: NHEButtonView!
    
    // Labels
    @IBOutlet weak var playLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var menuButton: UIButton!
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var isViewDidLayoutSubviews: Bool = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        guard !isViewDidLayoutSubviews else { return }
        self.tableViewHeightConstraint.constant = self.tableView.contentHeight
        self.tableViewHeightConstraint.constant = self.tableView.contentHeight
        isViewDidLayoutSubviews = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        State.shared.selectedCategories.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        playLabel.localize(with: "button.main.play")
    }
    
    override func setupGestures() {
        playView.addTapGesture(target: self, action: #selector(playViewTapped))
    }
    
    // MARK: - Gesture actions
    
    @objc func playViewTapped() {
        
        guard !State.shared.selectedCategories.isEmpty else {
            
            // TODO: - Haptic feedback
            
            let alert = AlertPopupViewController.load(from: Popup.alert)
            alert.initialize(title: localized("alert.noCategoriesChoosen.title"), message: localized("alert.noCategoriesChoosen.message"))
            self.showPopup(alert)
            
            return
        }
        
        let taskVC = TaskViewController.load(from: Main.task)
        self.navigationController?.pushViewController(taskVC, animated: true)
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        let settingsViewController = SettingsViewController.load(from: Main.settings)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.categoryCell.id, for: indexPath) as! CategoryTableViewCell
        
        cell.titleLabel.text = Category.all[indexPath.row].name.uppercased()
        cell.checkmarkView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        let category = Category.all[indexPath.row]
        
        if let index = State.shared.selectedCategories.firstIndex(of: category) {
            State.shared.selectedCategories.remove(at: index)
            cell.checkmarkView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        } else {
            State.shared.selectedCategories.append(category)
            cell.checkmarkView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
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
