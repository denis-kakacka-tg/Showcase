import UIKit
import Hero

final class HomeView: ContainerView {
    private var collectionLayout = UICollectionViewFlowLayout()
    
    let showListBarBtn: UIBarButtonItem = {
        let showListBtn = CustomButton(title: "+")
        return UIBarButtonItem(customView: showListBtn)
    }()
    
    let profileBarBtn: UIBarButtonItem = {
        let profileBtn = CustomButton(title: "P")
        return UIBarButtonItem(customView: profileBtn)
    }()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            showListBarBtn.customView!.widthAnchor.constraint(equalToConstant: 32),
            showListBarBtn.customView!.heightAnchor.constraint(equalToConstant: 32),
            
            profileBarBtn.customView!.widthAnchor.constraint(equalToConstant: 32),
            profileBarBtn.customView!.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: NSStringFromClass(EventCell.self))
        
        profileBarBtn.customView!.hero.id = "profileButton"
        showListBarBtn.customView!.hero.id = "showListButton"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension HomeView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCollectionLayout()
    }
}

// MARK: - Private
extension HomeView {
    private func setCollectionLayout() {
        collectionLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionLayout.itemSize = CGSize(width: frame.width, height: 44)
    }
}
