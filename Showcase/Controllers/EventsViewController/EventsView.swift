import UIKit

final class EventsView: ContainerView {
    private var collectionLayout = UICollectionViewFlowLayout()

    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: NSStringFromClass(EventCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension EventsView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCollectionLayout()
    }
}

// MARK: - Private
extension EventsView {
    private func setCollectionLayout() {
        collectionLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionLayout.itemSize = CGSize(width: frame.width, height: 44)
    }
}
