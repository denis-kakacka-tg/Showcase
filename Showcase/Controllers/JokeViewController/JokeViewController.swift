import UIKit
import RxSwift
import RxDataSources

final class JokeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: JokeViewModelType
    
    private var containerView: JokeView {
        return view as! JokeView
    }

    init(_ viewModel: JokeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension JokeViewController {
    override func loadView() {
        view = JokeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.jokeLabel.addBorder(side: .bottom, thickness: 1, color: ThemeManager.current.tintColor, bottomOffset: -12)
    }
}

// MARK: - Rx
extension JokeViewController {
    private func setupRx() {
        // MARK: Inputs
        containerView.refreshButton.rx.tap
            .bind(to: viewModel.inputs.didRefreshJoke)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        viewModel.outputs.joke
            .map { $0.value }
            .bind(to: containerView.jokeLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - Public
extension JokeViewController {

}

// MARK: - Private
extension JokeViewController {

}

// MARK: - UI
extension JokeViewController {
    private func setupUI() {
        
    }
}
