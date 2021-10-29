import UIKit

class BaseViewController: UIViewController {

    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.localize()
        self.configureUI()
        self.setupGestures()
    }
    
    // MARK: - Custom functions
    
    open func localize() { }
    open func configureUI() { }
    open func setupGestures() { }
    
    public func configure(_ tableView: UITableView, with cells: Cell...) {
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        for cell in cells {
            tableView.registerCell(cell: cell)
        }
    }
    
    public func configure(_ collectionView: UICollectionView, with cells: Cell...) {
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        for cell in cells {
            collectionView.registerCell(cell: cell)
        }
    }
    
    func hapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
