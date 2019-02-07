import Foundation
import RxSwift

protocol ProfileViewModelInputs {
    var didTapSettings: PublishSubject<Void> { get }
    var didTapClose: PublishSubject<Void> { get }
}

protocol ProfileViewModelOutputs {
    var close: Observable<Void> { get }
    var showSettings: Observable<Void> { get }
}

protocol ProfileViewModelType {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModel: ProfileViewModelType {
    var inputs: ProfileViewModelInputs { return self }
    var outputs: ProfileViewModelOutputs { return self }
    
    // MARK: Inputs
    let didTapClose = PublishSubject<Void>()
    let didTapSettings = PublishSubject<Void>()
    
    // MARK: Outputs
    let close: Observable<Void>
    let showSettings: Observable<Void>
    
    init() {
        close = didTapClose
        showSettings = didTapSettings
    }
}

extension ProfileViewModel: ProfileViewModelInputs, ProfileViewModelOutputs {}
