import UIKit
import RxSwift
import Hero

final class EventsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: EventsViewModelType
    
    private var containerView: EventsView {
        return view as! EventsView
    }
    
    init(_ viewModel: EventsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension EventsViewController {
    override func loadView() {
        view = EventsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension EventsViewController {
    private func setupRx() {
        // MARK: Inputs
        containerView.collectionView.rx.modelSelected(EventModel.self)
            .bind(to: viewModel.inputs.didSelectEvent)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        viewModel.outputs.events
            .map { $0.events }
            .asDriver(onErrorJustReturn: [])
            .drive(containerView.collectionView.rx
                .items(cellIdentifier: NSStringFromClass(EventCell.self), cellType: EventCell.self)) { _, model, cell in
                    cell.configure(with: model)
                    cell.hero.modifiers = [.scale(0.75)]
            }.disposed(by: disposeBag)
    }
}

// MARK: - Public
extension EventsViewController {
    
}

// MARK: - Private
extension EventsViewController {
    
}

// MARK: - UI
extension EventsViewController {
    private func setupUI() {        
        
    }
}
