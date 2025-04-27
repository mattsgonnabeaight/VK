import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didLoginSuccessfully()
}

final class LoginCoordinator {
    
    weak var delegate: LoginCoordinatorDelegate?
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginService = CheckerService() // Пример зависимости
        let viewModel = LoginViewModel(checkerService: loginService)
        viewModel.delegate = self
        let loginVC = LoginViewController(delegate: self) // Передаем делегат

        loginVC.viewModel = viewModel
        navigationController.setViewControllers([loginVC], animated: false)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Используем service для проверки данных
        let checkerService = CheckerService()
        checkerService.checkCredentials(email: email, password: password) { result in
            completion(result)
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let checkerService = CheckerService()
        checkerService.signUp(email: email, password: password, completion: completion)
    }
}

extension LoginCoordinator: LoginViewModelDelegate {
    func didLoginSuccessfully() {
        delegate?.didLoginSuccessfully()
    }
    
    func loginDidFail(with error: Error) {
        let alert = UIAlertController(
            title: "Login Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
}

