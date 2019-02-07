import UIKit
import RxSwift

final class EventsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: EventDetailViewModelType
    private let label = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 44)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    init(_ viewModel: EventDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension EventsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        registerCells()
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension EventsViewController {
    private func setupRx() {
        
        // MARK: Outputs
        viewModel.outputs.events
            .map { $0.events }
            .bind(to: collectionView.rx.items(cellIdentifier: NSStringFromClass(EventCell.self), cellType: EventCell.self)) { _, model, cell in
                cell.configure(with: model)
            }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(EventModel.self)
            .bind(to: viewModel.inputs.didSelectEvent)
            .disposed(by: disposeBag)
    }
}

// MARK: - Public
extension EventsViewController {
    
}

// MARK: - Private
extension EventsViewController {
    private func registerCells() {
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: NSStringFromClass(EventCell.self))
    }
}

// MARK: - UI
extension EventsViewController {
    private func setupUI() {        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        label.adjustsFontSizeToFitWidth = true
    }
}
