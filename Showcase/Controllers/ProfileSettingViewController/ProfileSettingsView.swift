import UIKit

final class ProfileSettingsView: ContainerView {
    let lightThemeBtn = CustomButton(title: "Light me")
    let darkThemeBtn = CustomButton(title: "Dark me")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lightThemeBtn.translatesAutoresizingMaskIntoConstraints = false
        darkThemeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lightThemeBtn)
        addSubview(darkThemeBtn)
        
        NSLayoutConstraint.activate([
            lightThemeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            lightThemeBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            lightThemeBtn.widthAnchor.constraint(equalToConstant: 132),
            
            darkThemeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            darkThemeBtn.topAnchor.constraint(equalTo: lightThemeBtn.bottomAnchor, constant: 16),
            darkThemeBtn.widthAnchor.constraint(equalToConstant: 132)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension ProfileSettingsView {
    func set(with theme: Theme) {
        darkThemeBtn.backgroundColor = theme.tintColor
        lightThemeBtn.backgroundColor = theme.tintColor
        darkThemeBtn.setTitleColor(theme.navBarColor, for: .normal)
        lightThemeBtn.setTitleColor(theme.navBarColor, for: .normal)
        backgroundColor = theme.navBarColor
    }
}

