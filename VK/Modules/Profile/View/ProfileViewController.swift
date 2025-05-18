import UIKit
import FirebaseAuth
import RealmSwift

final class ProfileViewController: UIViewController {

    private let headerView = ProfileHeaderView()
    private let logoutButton = UIButton(type: .system)

    
    private let viewModel: ProfileViewModel

        init(viewModel: ProfileViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Профиль"

        setupHeader()
        setupLogoutButton()
        loadUserData()
    }

    private func setupHeader() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func loadUserData() {
        guard let user = try? Realm().objects(UserObject.self).first else { return }
        headerView.fullNameLabel.text = user.fullName
    }

    @objc private func logoutTapped() {
        do {
            try Auth.auth().signOut()
            
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
            
            NotificationCenter.default.post(name: .didLogout, object: nil)
        } catch {
            print("Ошибка при логауте: \(error.localizedDescription)")
        }
    }
}
