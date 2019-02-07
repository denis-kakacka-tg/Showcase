import UIKit
import Hero

final class ProfileView: ContainerView {
    let settingsBtn = CustomButton(title: "Settings")
    
    let closeBarBtn: UIBarButtonItem = {
        let closeBtn = CustomButton(title: "X")
        return UIBarButtonItem(customView: closeBtn)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsBtn.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(settingsBtn)
        
        NSLayoutConstraint.activate([
            settingsBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsBtn.widthAnchor.constraint(equalToConstant: 132),
            
            closeBarBtn.customView!.widthAnchor.constraint(equalToConstant: 32),
            closeBarBtn.customView!.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        settingsBtn.hero.id = "profileButton"
        closeBarBtn.customView!.hero.id = "showListButton"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
