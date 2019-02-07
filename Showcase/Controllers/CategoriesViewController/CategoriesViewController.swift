import UIKit
import RxSwift
import RxCocoa

final class CategoriesViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: CategoriesViewModelType
    private let closeBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 44)
        
        return UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    }()
    
    init(viewModel: CategoriesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension CategoriesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCells()
        setupRx()
    }
}

// MARK: - Rx
extension CategoriesViewController {
    private func setupRx() {
        // MARK: Outputs
        viewModel.outputs.events
//            .map { $0 }
            .bind(to: collectionView.rx.items(cellIdentifier: NSStringFromClass(EventCell.self), cellType: EventCell.self)) { _, model, cell in
                cell.configure(with: model)
            }.disposed(by: disposeBag)
        
        closeBtn.rx.tap.bind(to: viewModel.inputs.closeTapped).disposed(by: disposeBag)
        collectionView.rx.modelSelected(EventCategoryModel.self).bind(to: viewModel.inputs.cellTapped).disposed(by: disposeBag)
    }
}

// MARK: - Public
extension CategoriesViewController {
    
}

// MARK: - Private
extension CategoriesViewController {
    private func registerCells() {
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: NSStringFromClass(EventCell.self))
    }
}

// MARK: - UI
extension CategoriesViewController {
    private func setupUI() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        navigationItem.leftBarButtonItem = closeBtn
    }
}

