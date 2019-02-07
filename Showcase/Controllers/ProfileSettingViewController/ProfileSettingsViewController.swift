import UIKit
import RxSwift
import RxCocoa

final class ProfileSettingsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileSettingsViewModelType
    
    fileprivate var containerView: ProfileSettingsView {
        return view as! ProfileSettingsView
    }
    
    init(viewModel: ProfileSettingsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension ProfileSettingsViewController {
    override func loadView() {
        view = ProfileSettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension ProfileSettingsViewController {
    private func setupRx() {
        //  MARK: Inputs
        let themeTapped = Observable.merge(
            containerView.lightThemeBtn.rx.tap.map { Theme.light },
            containerView.darkThemeBtn.rx.tap.map { Theme.dark }
        )
        
        themeTapped
            .bind(to: viewModel.inputs.didChangeTheme)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        viewModel.outputs.theme
            .asDriver(onErrorJustReturn: Theme.light)
            .drive(rx.theme)
            .disposed(by: disposeBag)
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

// MARK: - Binders
extension Reactive where Base: ProfileSettingsViewController {
    fileprivate var theme: Binder<Theme> {
        return Binder(base, binding: { (view, theme) in
            ThemeManager.apply(theme: theme)
            // na scene kde prestavujeme temu to potrebujeme este nastavit takto aby sme videli zmeny okamzite, pretoze appeareance to nezmeni
            view.navigationController?.navigationBar.barTintColor = theme.navBarColor
            view.containerView.set(with: theme)
        })
    }
}
