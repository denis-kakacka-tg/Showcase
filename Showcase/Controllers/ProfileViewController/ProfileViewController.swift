import UIKit
import RxSwift

final class ProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileViewModelType
    
    init(viewModel: ProfileViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension ProfileViewController {
    private func setupRx() {
        // MARK: Inputs
        
        // MARK: Outputs
        
    }
}

// MARK: - Public
extension ProfileViewController {
    
}

// MARK: - Private
extension ProfileViewController {
    
}

// MARK: - UI
extension ProfileViewController {
    private func setupUI() {
        
    }
}
