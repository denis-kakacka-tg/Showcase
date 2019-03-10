import UIKit

final class EventCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            ])
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension EventCell {
    func configure(with category: Category) {
        label.text = category
        label.numberOfLines = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        label.textColor = ThemeManager.current.navBarColor
    }
    
    func configure(with joke: JokeModel) {
        label.text = joke.value
        layer.cornerRadius = 0
        clipsToBounds = false
        backgroundColor = ThemeManager.current.navBarColor
        label.textColor = ThemeManager.current.tintColor
        
        addBorder(side: .bottom, thickness: 1, color: ThemeManager.current.tintColor, leftOffset: 8, rightOffset: 8)
    }
}

