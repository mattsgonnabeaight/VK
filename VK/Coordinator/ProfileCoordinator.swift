import UIKit

final class ProfileCoordinator: Coordinator {
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileViewModel)
        navigationController.pushViewController(profileVC, animated: true) // Переход на экран профиля
    }
}

