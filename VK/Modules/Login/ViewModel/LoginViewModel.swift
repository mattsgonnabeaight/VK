import Foundation

final class LoginViewModel {
    private let checkerService: CheckerService
    weak var delegate: LoginViewModelDelegate?

    var username: String = ""
    var password: String = ""

    init(checkerService: CheckerService) {
        self.checkerService = checkerService
    }

    func login() {
        print("Attempting login with email: \(username) and password: \(password)")
        checkerService.checkCredentials(email: username, password: password) { [weak self] result in
            switch result {
            case .success:
                print("Login successful!")
                self?.delegate?.didLoginSuccessfully()
            case .failure(let error):
                print("Login failed with error: \(error.localizedDescription)")
                self?.delegate?.loginDidFail(with: error)
            }
        }
    }

    func register() {
        print("Attempting register with email: \(username) and password: \(password)")
        checkerService.signUp(email: username, password: password) { [weak self] result in
            switch result {
            case .success:
                print("Register successful!")
                self?.delegate?.didLoginSuccessfully()
            case .failure(let error):
                print("Register failed with error: \(error.localizedDescription)")
                self?.delegate?.loginDidFail(with: error)
            }
        }
    }
}
