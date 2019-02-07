import UIKit
import RxSwift
import Hero

final class ProfileCoordinator: BaseCoordinator<Void> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewModel: ProfileViewModelType = ProfileViewModel()
        let viewController = ProfileViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.hero.isEnabled = true
        navigationController.hero.modalAnimationType = .fade
            //.selectBy(presenting: .fade, dismissing: .slide(direction: .down))
        
        rootViewController.present(navigationController, animated: true, completion: nil)
        
        viewModel.outputs.showSettings
            .subscribe(onNext: { [weak self] _ in
                self?.pushProfileSettings(on: navigationController)
            })
            .disposed(by: disposeBag)
        
        return viewModel.outputs.close
            .take(1)
            .do(onNext: { [weak self] _ in
                self?.rootViewController.dismiss(animated: true)
            })
    }
}

extension ProfileCoordinator {
    private func pushProfileSettings(on: UINavigationController) {
        let viewModel = ProfileSettingsViewModel()
        let viewController = ProfileSettingsViewController(viewModel: viewModel)
        
        on.pushViewController(viewController, animated: true)
    }
}
