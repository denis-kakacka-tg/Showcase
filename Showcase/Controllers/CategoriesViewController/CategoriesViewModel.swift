import Foundation
import RxSwift
import Moya


protocol CategoriesViewModelInputs {
    var didTapCategory: PublishSubject<Category> { get }
    var didTapClose: PublishSubject<Void> { get }
}

protocol CategoriesViewModelOutputs {
    var categories: Observable<Categories> { get }
    var showSelectedCategory: Observable<Category> { get }
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
    let didTapCategory = PublishSubject<Category>()
    let didTapClose = PublishSubject<Void>()
    
    // MARK: Outputs
    let categories: Observable<Categories>
    let showSelectedCategory: Observable<Category>
    let close: Observable<Void>
    
    init(provider: MoyaProvider<JokesRequest> = MoyaProvider<JokesRequest>()) {
        close = didTapClose
        showSelectedCategory = didTapCategory
        
        categories = Observable.just(Categories.self)
            .flatMapLatest { _ in provider.rx.request(.categories) }
            .map(Categories.self)
            .map { $0.map { $0.uppercased() }}
    }
}

extension CategoriesViewModel: CategoriesViewModelInputs, CategoriesViewModelOutputs {}
