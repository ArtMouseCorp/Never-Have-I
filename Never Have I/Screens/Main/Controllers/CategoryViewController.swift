import UIKit

class CategoryViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var playView: NHEButtonView!
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(collectionView, with: Cell.categoryCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        State.shared.selectedCategories.removeAll()
        collectionView.reloadData()
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoryCell.id, for: indexPath) as! CategoryCollectionViewCell
        cell.widthConstraint.constant = (UIScreen.main.bounds.width - 70) / 2
        cell.categoryTitleLabel.text = Category.all[indexPath.row].name
        cell.categoryBackgroundImageView.image = UIImage(named: "category-\(indexPath.row)") ?? UIImage()
        cell.categoryIndicatorImageView.image = UIImage(named: "category-deselected") ?? UIImage()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        let category = Category.all[indexPath.row]
        
        if let index = State.shared.selectedCategories.firstIndex(of: category) {
            State.shared.selectedCategories.remove(at: index)
            cell.categoryIndicatorImageView.image = UIImage(named: "category-deselected") ?? UIImage()
        } else {
            State.shared.selectedCategories.append(category)
            cell.categoryIndicatorImageView.image = UIImage(named: "category-selected") ?? UIImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 70) / 2
        let height = (width / 181) * 152
        return CGSize(width: width, height: height)
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
