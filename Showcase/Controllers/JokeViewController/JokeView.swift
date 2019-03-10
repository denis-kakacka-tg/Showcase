import UIKit

final class JokeView: ContainerView {
    let jokeLabel = UILabel()
    let refreshButton = CustomButton(title: "New joke")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(jokeLabel)
        addSubview(refreshButton)
        
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        jokeLabel.adjustsFontSizeToFitWidth = true
        jokeLabel.textAlignment = .center
        jokeLabel.textColor = ThemeManager.current.tintColor
        
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 128),
            jokeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            jokeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),

            refreshButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 24),
            refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



