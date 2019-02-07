import Foundation
import RxSwift

protocol ProfileSettingsViewModelInputs {
    var didChangeTheme: PublishSubject<Theme> { get }
}

protocol ProfileSettingsViewModelOutputs {
    var theme: Observable<Theme> { get }
}

protocol ProfileSettingsViewModelType {
    var inputs: ProfileSettingsViewModelInputs { get }
    var outputs: ProfileSettingsViewModelOutputs { get }
}

struct ProfileSettingsViewModel: ProfileSettingsViewModelType {
    var inputs: ProfileSettingsViewModelInputs { return self }
    var outputs: ProfileSettingsViewModelOutputs { return self }
    
    // MARK: Inputs
    let didChangeTheme = PublishSubject<Theme>()
    
    // MARK: Outputs
    let theme: Observable<Theme>
    
    init() {
        theme = didChangeTheme
    }
}

extension ProfileSettingsViewModel: ProfileSettingsViewModelInputs, ProfileSettingsViewModelOutputs {}
