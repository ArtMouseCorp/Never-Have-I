import UIKit
import Koloda

class TaskViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cardView: KolodaView!
    @IBOutlet weak var nextView: NHEButtonView!
        
    // Labels
    @IBOutlet weak var nextLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
        
    // MARK: - Variables
    
    var tasks: [String] = []
    var subscriptionConfig: SubscriptionPage = .default
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTasks()
        self.subscriptionConfig = RCValues.sharedInstance.subscriptionPage()
        
        cardView.delegate = self
        cardView.dataSource = self
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        nextLabel.localize(with: "button.game.next")
    }
    
    override func setupGestures() {
        nextView.addTapGesture(target: self, action: #selector(nextViewPressed))
    }
    
    private func loadTasks() {
        self.tasks.removeAll()
        State.shared.selectedCategories.forEach { self.tasks.append(contentsOf: $0.tasks) }
        self.tasks.shuffle()
    }
    
    // MARK: - Gesture actions
    
    @objc func nextViewPressed() {
        cardView.swipe(.left)
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TaskViewController: KolodaViewDelegate, KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        let card = CardViewController.load(from: Main.card)
        card.initialize(with: tasks[index])
        
        return card.view
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return tasks.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let gameOverViewController = GameOverViewController.load(from: Main.gameover)
        gameOverViewController.modalPresentationStyle = .fullScreen
        self.present(gameOverViewController, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return SwipeResultDirection.allCases
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
//        if index == subscriptionConfig.freeCards && !State.shared.isSubscribed {
//            let subscriptionViewController = SubscriptionViewController.load(from: Main.subscription)
//            subscriptionViewController.modalPresentationStyle = .fullScreen
//            subscriptionViewController.onCloseButtonPressed = {
//                self.navigationController?.popViewController(animated: true)
//            }
//            self.present(subscriptionViewController, animated: true, completion: nil)
//        }
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
