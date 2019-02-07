import UIKit
import RxSwift

final class ProfileCoordinator: BaseCoordinator<Void> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewModel: ProfileViewModelType = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        rootViewController.present(navigationController, animated: true, completion: nil)
        
//        let profile = viewModel.outputs.profile.map { ProfileCoordinatorResult.profile($0) }
//        let close = viewModel.outputs.close.map { ProfileCoordinatorResult.close }
        
        return Observable.just(())
//            Observable.merge(profile, close)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}
