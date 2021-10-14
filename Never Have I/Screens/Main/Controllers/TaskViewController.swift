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
    var isSubscribed = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.delegate = self
        cardView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        nextLabel.localize(with: "cards.next", defaultValue: "NEXT")
    }
    
    private func setupGestures() {
        nextView.addTapGesture(target: self, action: #selector(nextViewPressed))
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
        
        card.descriptionLabelText = tasks[index].uppercased()
        card.view.roundCorners(radius: 18, corners: .allCorners)
        card.view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        card.view.layer.shadowOpacity = 1
        card.view.layer.shadowRadius = 4
        card.view.layer.shadowOffset = CGSize(width: 0, height: 4)
        
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
        if index == 2 && !isSubscribed {
            let subscriptionViewController = SubscriptionViewController.load(from: Main.subscription)
            subscriptionViewController.modalPresentationStyle = .fullScreen
            subscriptionViewController.onCloseButtonPressed = {
                self.navigationController?.popViewController(animated: true)
            }
            self.present(subscriptionViewController, animated: true, completion: nil)
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
