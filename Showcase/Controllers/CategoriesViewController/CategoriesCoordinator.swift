import UIKit
import RxSwift

//enum EventsCoordinatorResult {
//    case close
//    case event(EventModel)
//}

final class CategoriesCoordinator: BaseCoordinator<Void> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewModel: CategoriesViewModelType = CategoriesViewModel()
        let viewController = CategoriesViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let selectedEvent = viewModel.inputs.cellTapped
            .subscribe(onNext: { [weak self ] (event) in
                self?.pushEventDetail(on: navigationController, with: event)
            })
        
        let close = viewModel.outputs.close
            .do(onNext: { [weak self] _ in
                self?.rootViewController.dismiss(animated: true, completion: nil)
            })
            .take(1)
        
        rootViewController.present(navigationController, animated: true, completion: nil)
        
        return close
    }
}

// MARK: - Private
extension CategoriesCoordinator {
    // ak potrebujeme nieco vratit presentujeme coordinator
    private func pushEventDetail(on: UINavigationController, with model: EventCategoryModel) {
        let viewModel = EventDetailViewModel(model: model)
        let eventDetailViewController = EventDetailViewController(viewModel)
        
        on.pushViewController(eventDetailViewController, animated: true)
    }
}
    
//    private func showEvents(on: UINavigationController, with model: EventCategoryModel) ->  {
//        let viewModel = EventDetailViewModel(model: model)
//        let eventDetailViewController = EventDetailViewController(viewModel)
//
//        on.pushViewController(eventDetailViewController, animated: true)
//    }}
