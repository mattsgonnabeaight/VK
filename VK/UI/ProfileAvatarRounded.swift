import UIKit

class ProfileAvatarRounded: UIImageView {
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: cornerRadius * 2,
            height: cornerRadius * 2
        )
    }
}
