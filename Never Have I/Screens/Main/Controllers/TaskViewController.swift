import UIKit
import Koloda

class TaskViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cardView: KolodaView!
    @IBOutlet weak var nextView: NHEButtonView!
    
    // Labels
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    
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
        cardView.delegate = self
        cardView.dataSource = self
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
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
        card.titleLabelText = "NEVER HAVE I EVER"
        card.descriptionLabelText = "DATED TWO OR MORE PEOPLE AT THE SAME TIME"
        card.view.roundCorners(radius: 18, corners: .allCorners)
        return card.view
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return 50
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
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
