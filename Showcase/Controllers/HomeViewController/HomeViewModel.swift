import Foundation
import RxSwift

protocol HomeViewModelInputs {
    
}

protocol HomeViewModelOutputs {
    
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModel: HomeViewModelType {
    public var inputs: HomeViewModelInputs { return self }
    public var outputs: HomeViewModelOutputs { return self }
}

extension HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs { }
