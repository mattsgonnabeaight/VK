import UIKit

final class PostTableViewCell: UITableViewCell {

    static let identifier = "PostTableViewCell"

    private let authorLabel = UILabel()
    private let postTextLabel = UILabel()
    private let likeButton = UIButton(type: .system)

    var likeButtonTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with post: Post) {
        authorLabel.text = post.author
        postTextLabel.text = post.text
        let heartImage = post.isLiked ? "❤️" : "🤍"
        likeButton.setTitle(heartImage, for: .normal)
    }

    private func setupUI() {
        authorLabel.font = .boldSystemFont(ofSize: 16)
        postTextLabel.font = .systemFont(ofSize: 14)
        postTextLabel.numberOfLines = 0

        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [authorLabel, postTextLabel, likeButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    @objc private func likeButtonPressed() {
        likeButtonTapped?()
    }
}
