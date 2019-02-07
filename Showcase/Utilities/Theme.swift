import UIKit

enum Theme {
    case dark, light
    
    var tintColor: UIColor {
        switch self {
        case .dark:
            return .showcaseBlue
        case .light:
            return .showcaseDarkBlue
        }
    }
    
    var navBarColor: UIColor {
        switch self {
        case .dark:
            return .showcaseDarkBlue
        case .light:
            return .showcaseBlue
        }
    }
}

struct ThemeManager {
    private(set) static var current: Theme = .dark
    
    static func apply(theme: Theme) {
        current = theme
        UIApplication.shared.delegate?.window??.tintColor = theme.tintColor
        UINavigationBar.appearance().barTintColor = theme.navBarColor
        UICollectionView.appearance().backgroundColor = theme.navBarColor
        UIImageView.appearance().tintColor = theme.tintColor
        EventCell.appearance().backgroundColor = theme.tintColor
        ContainerView.appearance().backgroundColor = theme.navBarColor
        CustomButton.appearance().backgroundColor = theme.tintColor
        CustomButton.appearance().setTitleColor(theme.navBarColor, for: .normal)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
}
