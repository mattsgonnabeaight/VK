import Foundation

final class FavoritePostsViewModel {
    var favoritePosts: [FavoritePost] = []
    
    func loadFavoritePosts() {
        self.favoritePosts = CoreDataManager.shared.fetchFavoritePosts()
    }
}
