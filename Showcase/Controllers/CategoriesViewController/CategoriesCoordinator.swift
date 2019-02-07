import UIKit
import RxSwift
import Hero

enum CategoriesCoordinatorResult {
    case close
    case event(EventModel)
}

final class CategoriesCoordinator: BaseCoordinator<CategoriesCoordinatorResult> {
    // Toto je root controller daneho coordinatoru, nie celej APP 
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CategoriesCoordinatorResult> {
        let viewModel: CategoriesViewModelType = CategoriesViewModel()
        let viewController = CategoriesViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
      
        // Hero framework pre transitions a animacie
        navigationController.hero.isEnabled = true
        navigationController.hero.modalAnimationType = .fade//.selectBy(presenting: .fade,
//                                                                 dismissing: .slide(direction: .down))
        
        rootViewController.present(navigationController, animated: true, completion: nil)

        let selectedModel = viewModel.inputs.didTapCell
            .flatMap { [weak self] (model) -> Observable<EventModel> in
                guard let self = self else { return Observable.empty() }
                return self.pushEvents(on: navigationController, with: model)
            }
            .map { CategoriesCoordinatorResult.event($0) }
        
        let close = viewModel.outputs.close
            .map { CategoriesCoordinatorResult.close }
        
        // Cakame dokym jedna z observables emituje nejaky event, nasledne returnujeme a coordinator sa vyhodi z pamate
        // vid. ako funguje 'BaseCoordinator'
        return Observable.merge(close, selectedModel)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}

// MARK: - Private
extension CategoriesCoordinator {
    /// Prezentujeme scenu
    ///
    /// - Parameters:
    ///   - on: Controller na ktorom bude prezentovana dalsia scena
    ///   - model: Model, ktorym danu scenu nastavime
    /// - Returns: Vraciame selektnuty model v dalsej scene
    private func pushEvents(on: UIViewController, with model: EventCategoryModel) -> Observable<EventModel> {
        let eventsCoordinator = EventsCoordinator(rootViewController: on, with: model)
        // 'EventsCoordinator' vracia enum 'EventsCoordiantorResult' ale tato funckcia nam uz vracia konkretny model
        // takze si z enumu vytiahneme nas model a vratime ho
        return coordinate(to: eventsCoordinator)
            .map({ (result) in
                switch result {
                case .event(let eventModel):
                    return eventModel
                }
        })
    }
}
