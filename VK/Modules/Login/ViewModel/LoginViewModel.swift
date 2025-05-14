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
        checkerService.checkCredentials(email: username, password: password) { [weak self] result in
            switch result {
            case .success:
                RealmUserManager.shared.saveAuthorizedUser(email: self?.username ?? "")
                self?.delegate?.didLoginSuccessfully()
            case .failure(let error):
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
