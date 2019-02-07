import UIKit
import RxSwift

final class ProfileSettingsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileSettingsViewControllerViewModel
    
    init(viewModel: ProfileSettingsViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension ProfileSettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension ProfileSettingsViewController {
    private func setupRx() {
        // MARK: Inputs
        
        // MARK: Outputs
    }
}

// MARK: - Public
extension ProfileSettingsViewController {
    
}

// MARK: - Private
extension ProfileSettingsViewController {
    
}

// MARK: - UI
extension ProfileSettingsViewController {
    private func setupUI() {
        
    }
}
