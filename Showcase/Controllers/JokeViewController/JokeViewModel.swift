import Foundation
import RxSwift
import Moya

protocol JokeViewModelInputs {
    var didSelectJoke: PublishSubject<JokeModel> { get }
    var didRefreshJoke: BehaviorSubject<Void> { get }
}

protocol JokeViewModelOutputs {
    var selectedJoke: Observable<JokeModel> { get }
    var joke: Observable<JokeModel> { get }
//    var loading: Observable<Bool> { get }
}

protocol JokeViewModelType {
    var inputs: JokeViewModelInputs { get }
    var outputs: JokeViewModelOutputs { get }
}

struct JokeViewModel: JokeViewModelType {
    var inputs: JokeViewModelInputs { return self }
    var outputs: JokeViewModelOutputs { return self }
    
    // MARK: Inputs
    let didSelectJoke = PublishSubject<JokeModel>()
    let didRefreshJoke = BehaviorSubject<Void>(value: ())

    // MARK: Outputs
    let selectedJoke: Observable<JokeModel>
    let joke: Observable<JokeModel>
    var loading: Observable<Bool> {
        return isLoading
    }
    
    // MARK: Helper subjects
    private let isLoading = PublishSubject<Bool>()

    init(category: Category, provider: MoyaProvider<JokesRequest> = MoyaProvider<JokesRequest>()) {
        isLoading = loading
        
        selectedJoke = didSelectJoke
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        joke = didRefreshJoke
            .flatMapLatest { _ -> Single<Response> in
                loading.onNext(true)
                return provider.rx.request(.randomInCategory(category: category.lowercased()))
            }
            .map(JokeModel.self, using: decoder)
            .do {
                loading.onNext(false)
        }
    }
}

extension JokeViewModel: JokeViewModelInputs, JokeViewModelOutputs {}
