import UIKit

class CustomButton: UIButton {
    var title: String
    var titleColor: UIColor
    var buttonColor: UIColor
    
    typealias Action = () -> Void
    var buttonAction: Action
    
    required init(title: String, titleColor: UIColor, buttonColor: UIColor, action: @escaping Action) {
        self.title = title
        self.titleColor = titleColor
        self.buttonColor = buttonColor
        buttonAction = action
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = buttonColor
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.7
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton {
    
    @objc
    private func buttonTapped() {
        buttonAction()
    }
}
