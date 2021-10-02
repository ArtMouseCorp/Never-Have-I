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
    
    let categoriesData = ["POPULAR", "DIRTY & SEX", "PARTY", "RELATIONSHIP", "SCHOOL & WORK"]
    var selectedCategories: [Int] = []
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
        selectedCategories = []
        tableView.reloadData()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        configure(tableView)
        tableViewHeightConstraint.constant = tableView.contentHeight
    }
    
    private func setupGestures() {
        playView.addTapGesture(target: self, action: #selector(playViewTapped))
    }
    
    // MARK: - Gesture actions
    
    @objc func playViewTapped() {
        let taskViewController = TaskViewController.load(from: Main.task)
        self.navigationController?.pushViewController(taskViewController, animated: true)
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
        return categoriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.categoryCell.id, for: indexPath) as! CategoryTableViewCell
        
        cell.titleLabel.text = categoriesData[indexPath.row]
        cell.checkmarkView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        
        if let index = selectedCategories.firstIndex(of: indexPath.row) {
            selectedCategories.remove(at: index)
            cell.checkmarkView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        } else {
            selectedCategories.append(indexPath.row)
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
