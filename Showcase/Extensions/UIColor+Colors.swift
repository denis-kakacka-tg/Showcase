import UIKit

extension UIColor {
    convenience init(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
