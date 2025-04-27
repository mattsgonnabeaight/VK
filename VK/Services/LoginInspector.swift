final class LoginInspector: LoginViewControllerDelegate {
    private let checkerService: CheckerServiceProtocol

    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }

    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        checkerService.checkCredentials(email: email, password: password) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        checkerService.signUp(email: email, password: password, completion: completion)
    }
}
