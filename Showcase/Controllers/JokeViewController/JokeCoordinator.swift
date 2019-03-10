import UIKit
import RxSwift

enum JokesCoordiantorResult {
    case joke(JokeModel)
}

final class JokeCoordinator: BaseCoordinator<JokesCoordiantorResult> {
    private let rootViewController: UIViewController
    private let category: Category

    init(rootViewController: UIViewController, with category: Category) {
        self.rootViewController = rootViewController
        self.category = category
    }

    override func start() -> Observable<JokesCoordiantorResult> {
        let viewModel = JokeViewModel(category: category)
        let viewController = JokeViewController(viewModel)

        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            rootViewController.present(viewController, animated: true)
        }

        return viewModel.outputs.selectedJoke
            .map { JokesCoordiantorResult.joke($0) }
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}
