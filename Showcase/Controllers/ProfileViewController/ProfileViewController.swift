import UIKit
import RxSwift

final class ProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileViewModelType
    
    private var containerView: ProfileView {
        return view as! ProfileView
    }
    
    init(_ viewModel: ProfileViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension ProfileViewController {
    override func loadView() {
        view = ProfileView()
    }
    
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
        let barButtonCustomView = containerView.closeBarBtn.customView as! UIButton
        
        barButtonCustomView.rx.tap
            .bind(to: viewModel.inputs.didTapClose)
            .disposed(by: disposeBag)
        
        containerView.settingsBtn.rx.tap
            .bind(to: viewModel.inputs.didTapSettings)
            .disposed(by: disposeBag)
        
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
        navigationItem.leftBarButtonItem = containerView.closeBarBtn
    }
}
