import Foundation
import CoreData


extension FavoritePost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePost> {
        return NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var date: Date?

}
