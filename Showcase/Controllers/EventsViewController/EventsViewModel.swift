import Foundation
import RxSwift
import Moya

protocol EventsViewModelInputs {
    var didSelectEvent: PublishSubject<EventModel> { get }
}

protocol EventsViewModelOutputs {
    var selectedEvent: Observable<EventModel> { get }
    var events: Observable<Events> { get }
}

protocol EventsViewModelType {
    var inputs: EventsViewModelInputs { get }
    var outputs: EventsViewModelOutputs { get }
}

struct EventsViewModel: EventsViewModelType {
    var inputs: EventsViewModelInputs { return self }
    var outputs: EventsViewModelOutputs { return self }
    
    // MARK: Inputs
    let didSelectEvent = PublishSubject<EventModel>()
    
    // MARK: Outputs
    let events: Observable<Events>
    let selectedEvent: Observable<EventModel>

    init(model: EventCategoryModel, provider: MoyaProvider<EventRequests> = MoyaProvider<EventRequests>()) {
        selectedEvent = didSelectEvent
        
        // Pri inicializacii rovno vypalime request, namapujeme modely a posleme do outputu
        events = Observable.just(Events.self)
            .flatMapLatest{ _ in provider.rx.request(.eventsFor(keyword: model.keyword)) }
            .map(Embedded.self)
            .map { $0.embedded }
    }
}

extension EventsViewModel: EventsViewModelInputs, EventsViewModelOutputs { }
