import UIKit

final class EventCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension EventCell {
    func configure(with category: EventCategoryModel) {
        label.text = category.keyword
        layer.cornerRadius = 8
        clipsToBounds = true
        label.textColor = ThemeManager.current.navBarColor
    }
    
    func configure(with event: EventModel) {
        label.text = event.name
        layer.cornerRadius = 0
        clipsToBounds = false
        backgroundColor = ThemeManager.current.navBarColor
        label.textColor = ThemeManager.current.tintColor
        
        addBorder(side: .bottom, thickness: 1, color: ThemeManager.current.tintColor, leftOffset: 8, rightOffset: 8)
    }
}

