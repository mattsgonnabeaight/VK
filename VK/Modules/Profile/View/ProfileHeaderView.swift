import UIKit

class ProfileHeaderView: UIView {
    
    lazy var profileImage: UIImageView = {
        let image = UIImage(named: "profileImage") ?? UIImage(systemName: "person.circle")!
        let profileImage = ProfileAvatarRounded(image: image)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressProfileImage))
        tap.numberOfTapsRequired = 1
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.masksToBounds = true
        profileImage.cornerRadius = 65.0
        return profileImage
    }()

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusCustomButton: CustomButton = {
        let button = CustomButton(title: "show status", titleColor: .white, buttonColor: .black) { [unowned self] in
            print("Status button tapped")
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 250.0)
    }

    private func setupSubviews() {
        addSubview(profileImage)
        addSubview(fullNameLabel)
        addSubview(someLabel)
        addSubview(statusCustomButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 130),
            profileImage.heightAnchor.constraint(equalToConstant: 130),
            profileImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),

            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            fullNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),

            someLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            someLabel.centerXAnchor.constraint(equalTo: fullNameLabel.centerXAnchor),
            someLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            someLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16.0),

            statusCustomButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            statusCustomButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statusCustomButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusCustomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc
    private func didPressProfileImage() {
        print("Did tap Profile Image")
        launchAnimation()
    }

    private func launchAnimation() {
        let centerOrigin = profileImage.center

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("Did finish CAAnimation example")
        }

        let animationPosition = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animationPosition.toValue = CGPoint(x: 2.0 * centerOrigin.x, y: 2.0 * centerOrigin.y)
        animationPosition.duration = 0.5
        animationPosition.autoreverses = false
        animationPosition.isRemovedOnCompletion = false
        animationPosition.repeatCount = 1
        animationPosition.delegate = self
        profileImage.layer.add(animationPosition, forKey: #keyPath(CALayer.position))

        CATransaction.commit()
    }
}

extension ProfileHeaderView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("Did start CAAnimation example")
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Did stop CAAnimation example")
    }
}
