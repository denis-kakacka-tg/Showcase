import UIKit

final class EmptyCollectionPlaceholder: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension EmptyCollectionPlaceholder {
    private func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        label.text = "?"
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
}
