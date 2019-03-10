import UIKit
import RxSwift
import Hero

final class CategoriesViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: CategoriesViewModelType
    
    private var containerView: CategoriesView {
        return view as! CategoriesView
    }
    
    init(_ viewModel: CategoriesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension CategoriesViewController {
    override func loadView() {
        view = CategoriesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
}

// MARK: - Rx
extension CategoriesViewController {
    private func setupRx() {
        // MARK: Inputs
        let closeBarBtnCustomView = containerView.closeBarBtn.customView as! UIButton
        
        closeBarBtnCustomView.rx.tap
            .bind(to: viewModel.inputs.didTapClose)
            .disposed(by: disposeBag)
        
        containerView.collectionView.rx.modelSelected(Category.self)
            .bind(to: viewModel.inputs.didTapCategory)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        viewModel.outputs.categories
            .asDriver(onErrorJustReturn: [])
            .drive(containerView.collectionView.rx
                .items(cellIdentifier: NSStringFromClass(EventCell.self), cellType: EventCell.self)) { index, model, cell in
                    cell.configure(with: model)
                    cell.hero.modifiers = [.fade, .scale(0.5)]
            }.disposed(by: disposeBag)
    }
}

// MARK: - Public
extension CategoriesViewController {
    
}

// MARK: - Private
extension CategoriesViewController {
    
}

// MARK: - UI
extension CategoriesViewController {
    private func setupUI() {
        navigationItem.leftBarButtonItem = containerView.closeBarBtn
    }
}
