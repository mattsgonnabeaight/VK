protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccessfully()
    func loginDidFail(with error: Error)
}
