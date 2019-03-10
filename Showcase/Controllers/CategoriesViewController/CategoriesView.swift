import UIKit
import Hero

final class CategoriesView: ContainerView {
    private var collectionLayout = UICollectionViewFlowLayout()
    
    let closeBarBtn: UIBarButtonItem = {
        let closeBtn = CustomButton(title: "X")
        return UIBarButtonItem(customView: closeBtn)
    }()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            closeBarBtn.customView!.widthAnchor.constraint(equalToConstant: 32),
            closeBarBtn.customView!.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: NSStringFromClass(EventCell.self))
        collectionView.hero.modifiers = [.fade, .cascade(delta: 0.025, direction: .rightToLeft, delayMatchedViews: true)]
        closeBarBtn.customView!.hero.id = "showListButton"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension CategoriesView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCollectionLayout()
    }
}

// MARK: - Private
extension CategoriesView {
    private func setCollectionLayout() {
        collectionLayout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        let collectionWidthWithoutInsets = collectionView.bounds.width - 24
        collectionLayout.itemSize = CGSize(width: collectionWidthWithoutInsets * 0.3, height: 80)
    }
}
