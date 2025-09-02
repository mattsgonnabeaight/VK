import UIKit

final class AppCoordinator {
    var window: UIWindow
    var tabBarController: UITabBarController

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileViewModel)
        profileVC.title = "Профиль"
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 0)
        let profileNav = UINavigationController(rootViewController: profileVC)

        let feedVC = FeedViewController()
        feedVC.title = "Лента"
        feedVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "list.bullet.rectangle"), tag: 1)
        let feedNav = UINavigationController(rootViewController: feedVC)

        let favoriteVC = FavoritePostsViewController()
        favoriteVC.title = "Избранное"
        favoriteVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star.fill"), tag: 2)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)

        tabBarController.viewControllers = [profileNav, feedNav, favoriteNav]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
