import UIKit
import RxSwift

// v projekte je Schema.jpg kde si mozte pozret jak to cele vypada
// Behavior driven testy dorobim ked bude cas 

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModelType
    
    // Pomocou tohto sa zbavime zodpovednosti, pridavania views/buttonov a nastavovania ich constraints, pretoze
    // to nie je zodpovednost controllera
    private var containerView: HomeView {
        return view as! HomeView
    }
    
    init(_ viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension HomeViewController {
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension HomeViewController {
    private func setupRx() {
        // MARK: Inputs
        let showListBarBtnCustomView = containerView.showListBarBtn.customView as! UIButton
        let showProfileBarBtnCustomView = containerView.profileBarBtn.customView as! UIButton

        showListBarBtnCustomView.rx.tap
            .bind(to: viewModel.inputs.didTapShowList)
            .disposed(by: disposeBag)
        
        showProfileBarBtnCustomView.rx.tap
            .bind(to: viewModel.inputs.didTapShowProfile)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        viewModel.outputs.favorites
            .map { $0.events }
            .asDriver(onErrorJustReturn: [])
            .startWith([])
            .do(onNext: { [weak self] (events) in
                self?.handleCollection(empty: events.isEmpty)
            })
            .drive(containerView.collectionView.rx
                .items(cellIdentifier: NSStringFromClass(EventCell.self), cellType: EventCell.self)) { _, model, cell in
                    cell.configure(with: model)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Public
extension HomeViewController {
    
}

// MARK: - Private
extension HomeViewController {
    private func handleCollection(empty: Bool) {
        if empty {
            containerView.collectionView.backgroundView = EmptyCollectionPlaceholderView(frame: containerView.collectionView.frame)
        } else {
            containerView.collectionView.backgroundView = nil
        }
    }
}

// MARK: - UI
extension HomeViewController {
    private func setupUI() {
        navigationItem.leftBarButtonItem = containerView.profileBarBtn
        navigationItem.rightBarButtonItem = containerView.showListBarBtn
    }
}
