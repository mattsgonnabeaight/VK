import UIKit


final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    private var loginCoordinator: LoginCoordinator?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        if let storedUser = RealmUserManager.shared.getAuthorizedUser() {
            print("Автовход пользователя: \(storedUser.email)")
            showProfile()
        } else {
            showLogin()
        }
    }

    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        self.loginCoordinator = loginCoordinator
    }
    
    private func showProfile() {
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileViewModel)
        profileVC.delegate = self
        navigationController.setViewControllers([profileVC], animated: true)
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func didLoginSuccessfully() {
        showProfile()
    }
}

extension AppCoordinator: ProfileViewControllerDelegate {
    func didRequestLogout() {
        showLogin()
    }
}
