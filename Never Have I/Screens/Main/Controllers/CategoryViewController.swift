import UIKit

class CategoryViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var playView: NHEButtonView!
    
    // Labels
    
    // Buttons
    @IBOutlet weak var menuButton: UIButton!
    
    // Image Views
    // ...
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
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
