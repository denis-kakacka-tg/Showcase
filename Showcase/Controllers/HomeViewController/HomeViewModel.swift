import Foundation
import RxSwift

protocol HomeViewModelInputs {
    var didTapShowList: PublishSubject<Void> { get }
    var didTapShowProfile: PublishSubject<Void> { get }
    var didAddFavorite: PublishSubject<EventModel> { get }
}

protocol HomeViewModelOutputs {
    var showList: Observable<Void> { get }
    var showProfile: Observable<Void> { get }
    var favorites: Observable<Events> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModel: HomeViewModelType {
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    // MARK: Inputs
    let didTapShowList = PublishSubject<Void>()
    let didTapShowProfile = PublishSubject<Void>()
    let didAddFavorite = PublishSubject<EventModel>()
    
    // MARK: Outputs
    let showList: Observable<Void>
    let showProfile: Observable<Void>
    let favorites: Observable<Events>
        
    init() {
        var allFavs: Events = Events(events: [])
        showList = didTapShowList
        showProfile = didTapShowProfile
        favorites = didAddFavorite
            .flatMap({ (model) -> Observable<Events> in
                allFavs.events.append(model)
                return Observable.from(optional: allFavs)
            })
    }
}

extension HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs {}
