import UIKit
import RxSwift

enum EventsCoordiantorResult {
    case event(EventModel)
}

final class EventsCoordinator: BaseCoordinator<EventsCoordiantorResult> {
    private let rootViewController: UIViewController
    private let model: EventCategoryModel
    
    init(rootViewController: UIViewController, with model: EventCategoryModel) {
        self.rootViewController = rootViewController
        self.model = model
    }
    
    override func start() -> Observable<EventsCoordiantorResult> {
        let viewModel = EventsViewModel(model: model)
        let viewController = EventsViewController(viewModel)
        
        // Sceny s coordinatorom su nazavisle na scenach, ktore ju prezentuju, mozme teda v pripade ze scena
        // z ktorej to bolo prezentovane ma NavController tuto scenu pushnut, v pripade ze nie tak prezentovat
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            rootViewController.present(viewController, animated: true)
        }
        
        // Cakame kym user selectne model, ked ho selectne posielame tento model coordinatoru predtym
        return viewModel.outputs.selectedEvent
            .map { EventsCoordiantorResult.event($0) }
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}
