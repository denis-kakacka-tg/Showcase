import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewControllerViewModel
    
    init(viewModel: HomeViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension HomeViewController {
    private func setupRx() {
        
    }
}

// MARK: - Public
extension HomeViewController {
    
}

// MARK: - Private
extension HomeViewController {
    
}

// MARK: - UI
extension HomeViewController {
    private func setupUI() {
        
    }
}
