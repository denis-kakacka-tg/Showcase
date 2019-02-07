import Foundation
import RxSwift

protocol ProfileViewModelInputs {
    var profileTapped: PublishSubject<EventModel> { get }
    var closeTapped: PublishSubject<Void> { get }
}

protocol ProfileViewModelOutputs {
    var close: Observable<Void> { get }
    var profile: Observable<EventModel> { get }
}

protocol ProfileViewModelType {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModel: ProfileViewModelType {
    var inputs: ProfileViewModelInputs { return self }
    var outputs: ProfileViewModelOutputs { return self }
    
    // MARK: Inputs
    let closeTapped = PublishSubject<Void>()
    let profileTapped = PublishSubject<EventModel>()
    
    // MARK: Outputs
    let close: Observable<Void>
    let profile: Observable<EventModel>
    
    init() {
        close = closeTapped
        profile = profileTapped
    }
}

extension ProfileViewModel: ProfileViewModelInputs, ProfileViewModelOutputs {

}
