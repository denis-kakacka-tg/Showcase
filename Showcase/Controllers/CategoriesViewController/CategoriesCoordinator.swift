import UIKit
import RxSwift
import Hero

enum CategoriesCoordinatorResult {
    case close
    case event(EventModel)
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

        let selectedModel = viewModel.inputs.didTapCell
            .flatMap { [weak self] (model) -> Observable<EventModel> in
                guard let self = self else { return Observable.empty() }
                return self.pushEvents(on: navigationController, with: model)
            }
            .map { CategoriesCoordinatorResult.event($0) }
        
        let close = viewModel.outputs.close
            .map { CategoriesCoordinatorResult.close }
        
        return Observable.merge(close, selectedModel)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}

// MARK: - Private
extension CategoriesCoordinator {
    private func pushEvents(on: UIViewController, with model: EventCategoryModel) -> Observable<EventModel> {
        let eventsCoordinator = EventsCoordinator(rootViewController: on, with: model)
        return coordinate(to: eventsCoordinator)
            .map({ (result) in
                switch result {
                case .event(let eventModel):
                    return eventModel
                }
        })
    }
}
