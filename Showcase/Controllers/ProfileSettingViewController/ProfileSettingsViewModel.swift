import Foundation
import RxSwift

protocol ProfileSettingsViewModelInputs {
    
}

protocol ProfileSettingsViewModelOutputs {
    
}

protocol ProfileSettingsViewModelType {
    var inputs: ProfileSettingsViewModelInputs { get }
    var outputs: ProfileSettingsViewModelOutputs { get }
}

struct ProfileSettingsViewModel: ProfileSettingsViewModelType {
    var inputs: ProfileSettingsViewModelInputs { return self }
    var outputs: ProfileSettingsViewModelOutputs { return self }
    
    // MARK: Inputs
    
    // MARK: Outputs
}

extension ProfileSettingsViewModel: ProfileSettingsViewModelInputs, ProfileSettingsViewModelOutputs { }
