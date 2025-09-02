import UIKit
import FirebaseAuth
import RealmSwift

final class ProfileViewController: UIViewController {

    private let headerView = ProfileHeaderView()
    private let logoutButton = UIButton(type: .system)
    let currentUserEmail = Auth.auth().currentUser?.email ?? "Аноним"

    private let tableView = UITableView()
    private var posts: [Post] = []
    
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
        setupTableView()
        loadUserData()
        loadPosts()
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
    
    private func setupTableView() {
           view.addSubview(tableView)
           tableView.translatesAutoresizingMaskIntoConstraints = false

           tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
           tableView.dataSource = self
           tableView.delegate = self
           tableView.separatorStyle = .none

           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 16),
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    private func loadPosts() {
        let email = Auth.auth().currentUser?.email ?? "Аноним"
        posts = [
            Post(author: email, text: "Это мой первый пост!", isLiked: false),
            Post(author: email, text: "Привет, мир!", isLiked: true),
            Post(author: email, text: "Сегодня прекрасная погода.", isLiked: false)
        ]
        tableView.reloadData()
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
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }

        var post = posts[indexPath.row]
        cell.configure(with: post)

        cell.likeButtonTapped = { [weak self] in
            guard let self = self else { return }
            post.isLiked.toggle()
            self.posts[indexPath.row] = post
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        return cell
    }
}

