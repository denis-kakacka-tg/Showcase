import Foundation
import RxSwift
import Moya

protocol CategoriesViewModelInputs {
    var didTapCell: PublishSubject<EventCategoryModel> { get }
    var didTapClose: PublishSubject<Void> { get }
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
    let didTapCell = PublishSubject<EventCategoryModel>()
    let didTapClose = PublishSubject<Void>()
    
    // MARK: Outputs
    let events: Observable<[EventCategoryModel]>
    let close: Observable<Void>
    
    init() {
        close = didTapClose 
        events = Observable.of(
            [EventCategoryModel(keyword: "Music"),
             EventCategoryModel(keyword: "Sport"),
             EventCategoryModel(keyword: "Fun"),
             EventCategoryModel(keyword: "Music"),
             EventCategoryModel(keyword: "Sport"),
             EventCategoryModel(keyword: "Fun"),
             EventCategoryModel(keyword: "Music"),
             EventCategoryModel(keyword: "Sport"),
             EventCategoryModel(keyword: "Fun"),
             EventCategoryModel(keyword: "Music"),
             EventCategoryModel(keyword: "Sport"),
             EventCategoryModel(keyword: "Fun")
            ]
        )
    }
}

extension CategoriesViewModel: CategoriesViewModelInputs, CategoriesViewModelOutputs {}
