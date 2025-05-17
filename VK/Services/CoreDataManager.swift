import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritePostModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveFavoritePost(id: String, title: String, imageURL: String) {
        let post = FavoritePost(context: context)
        post.id = id
        post.title = title
        post.imageURL = imageURL
        post.date = Date()
        saveContext()
    }

    func fetchFavoritePosts() -> [FavoritePost] {
        let request: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch favorite posts: \(error)")
            return []
        }
    }
}
