import UIKit

final class FeedViewController: UIViewController {
    private let viewModel = FeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Лента"
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
    }

    @objc private func handleDoubleTap(gesture: UITapGestureRecognizer) {
        
        let postId = "post123"
        let postTitle = "Post Title"
        let postImageURL = "https://example.com/image.jpg"

        CoreDataManager.shared.saveFavoritePost(id: postId, title: postTitle, imageURL: postImageURL)
        
        print("Post added to favorites")
    }
}
