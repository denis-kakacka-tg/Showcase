import UIKit

enum Themes {
    case dark, light
    
    var tintColor: UIColor {
        switch self {
        case .dark:
            return .lightBlue
        case .light:
            return .darkBlue
        }
    }
    
    var navBarColor: UIColor {
        switch self {
        case .dark:
            return .darkBlue
        case .light:
            return .lightBlue
        }
    }
}

struct ThemeManager {
    private(set) static var current: Themes = .light
    
    static func apply(theme: Themes) {
        current = theme
        UIApplication.shared.delegate?.window??.tintColor = theme.tintColor
        UINavigationBar.appearance().barTintColor = theme.navBarColor
        UICollectionView.appearance().backgroundColor = theme.navBarColor
        UIImageView.appearance().tintColor = theme.tintColor
        EventCell.appearance().backgroundColor = theme.tintColor
        ContainerView.appearance().backgroundColor = theme.navBarColor
        CustomButton.appearance().backgroundColor = theme.tintColor
        CustomButton.appearance().setTitleColor(theme.navBarColor, for: .normal)
    }
}
