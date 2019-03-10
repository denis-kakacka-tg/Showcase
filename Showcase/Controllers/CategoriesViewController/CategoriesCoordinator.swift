import UIKit
import RxSwift
import Hero

enum CategoriesCoordinatorResult {
    case close
    case joke(JokeModel)
}

final class CategoriesCoordinator: BaseCoordinator<CategoriesCoordinatorResult> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CategoriesCoordinatorResult> {
        let viewModel: CategoriesViewModelType = CategoriesViewModel()
        let viewController = CategoriesViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.hero.isEnabled = true
        navigationController.hero.modalAnimationType = .selectBy(presenting: .fade, dismissing: .slide(direction: .right))
        rootViewController.present(navigationController, animated: true, completion: nil)

        let selectedCategory = viewModel.outputs.showSelectedCategory
            .flatMap { [weak self] (category) -> Observable<JokeModel> in
                guard let self = self else { return Observable.empty() }
                return self.showJokes(in: category, on: navigationController)
            }
            .map { CategoriesCoordinatorResult.joke($0) }
        
        let close = viewModel.outputs.close
            .map { CategoriesCoordinatorResult.close }
        
        return Observable.merge(close, selectedCategory)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}

// MARK: - Private
extension CategoriesCoordinator {
    private func showJokes(in category: Category, on: UIViewController) -> Observable<JokeModel> {
        let jokeCoordinator = JokeCoordinator(rootViewController: on, with: category)
        return coordinate(to: jokeCoordinator)
            .map({ (result) in
                switch result {
                case .joke(let jokeModel):
                    return jokeModel
                }
        })
    }
}
