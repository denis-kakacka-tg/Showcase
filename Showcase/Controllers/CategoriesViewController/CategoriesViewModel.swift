import Foundation
import RxSwift
import Moya

protocol CategoriesViewModelInputs {
    var cellTapped: PublishSubject<EventCategoryModel> { get }
    var closeTapped: PublishSubject<Void> { get }
}

protocol CategoriesViewModelOutputs {
    var events: Observable<[EventCategoryModel]> { get }
    var close: Observable<Void> { get }
}

protocol CategoriesViewModelType {
    var inputs: CategoriesViewModelInputs { get }
    var outputs: CategoriesViewModelOutputs { get }
}

struct CategoriesViewModel: CategoriesViewModelType {
    public var inputs: CategoriesViewModelInputs { return self }
    public var outputs: CategoriesViewModelOutputs { return self }
    
    // MARK: Inputs
    let cellTapped = PublishSubject<EventCategoryModel>()
    let closeTapped = PublishSubject<Void>()
    
    // MARK: Outputs
    let events: Observable<[EventCategoryModel]>
    let close: Observable<Void>
    
    init(provider: MoyaProvider<EventRequests> = MoyaProvider<EventRequests>()) {
        close = closeTapped // toto sa mi takto paci pretoze mozes ten event napr este nejak spracovat.. aj ked je to len tap, napr nastavit throttle
        
        //        events = Observable.just(Events.self)
        //            .flatMapLatest { _ in provider.rx.request(EventRequests.suggest) }
        //            .map(Embedded.self)
        //            .map { $0.embedded }
        
        events = Observable.of(
            [EventCategoryModel(keyword: "Music"),
             EventCategoryModel(keyword: "Sport"),
             EventCategoryModel(keyword: "Fun")
//             EventCategoryModel(keyword: "Music"),
//             EventCategoryModel(keyword: "Sport"),
//             EventCategoryModel(keyword: "Fun"),
//             EventCategoryModel(keyword: "Music"),
//             EventCategoryModel(keyword: "Sport"),
//             EventCategoryModel(keyword: "Fun")
            ]
        )
    }
}

extension CategoriesViewModel: CategoriesViewModelInputs, CategoriesViewModelOutputs {
}
