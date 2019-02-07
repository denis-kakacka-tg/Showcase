import UIKit
import RxSwift

final class HomeCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    /// Tato metodka sa vzdy vola ako prva, vlastne nainicializuje controller ktory sa zobrazi
    /// a pocuva na eventy, ktore posiela viewmodel
    /// - Returns: Vacsinou vracia 'Void' ale su situacie kedy chceme poslat informaciu z jedneho coordinatoru do coordinatoru ktory ho prezentoval, vid priklad 'showCategories' kde sa prezentuje dalsi coordinator a z neho este jeden a pom. nich sa dostanu data az do tejto sceny
    override func start() -> Observable<Void> {
        let viewModel: HomeViewModelType = HomeViewModel()
        let viewController = HomeViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.hero.isEnabled = true
        
        viewModel.outputs.showList
            .flatMap({ [weak self] _ -> Observable<CategoriesCoordinatorResult> in
                guard let self = self else { return Observable.empty() }
                return self.showCategories(on: navigationController)
            })
            .map { (result) -> EventModel? in
                switch result {
                case .event(let event): return event
                case .close: return nil
            }}
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.inputs.didAddFavorite)
            .disposed(by: disposeBag)
        
        viewModel.outputs.showProfile
            .flatMap({ [weak self] _ -> Observable<Void> in
                guard let self = self else { return Observable.empty() }
                return self.showProfile(on: viewController)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Observable.never() pretoze toto je root scena ktora je v pamati stale
        return Observable.never()
    }
}

// MARK: - Private
extension HomeCoordinator {
    
    /// Metodka vytvori a coordinuje do dalsieho coordinatoru, kde sa spusti jeho 'start()'
    ///
    /// - Parameter rootViewController: Controller, na ktorom sa bude prezentovat scena
    /// - Returns: Vracia enum 'CategoriesCoordinatorResult', kde su definovane moznosti ktore mozme poslat naspat
    private func showCategories(on rootViewController: UIViewController) -> Observable<CategoriesCoordinatorResult> {
        let categoriesCoordinator = CategoriesCoordinator(rootViewController: rootViewController)
        return coordinate(to: categoriesCoordinator)
    }
    
    private func showProfile(on rootViewController: UIViewController) -> Observable<Void> {
        let profileCoordinator = ProfileCoordinator(rootViewController: rootViewController)
        return coordinate(to: profileCoordinator)
    }
}
