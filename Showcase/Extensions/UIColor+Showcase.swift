import UIKit

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

extension UIColor {
    static let showcaseBlue = UIColor(224, 251, 252)
    static let showcaseDarkBlue = UIColor(61, 90, 128)
}
