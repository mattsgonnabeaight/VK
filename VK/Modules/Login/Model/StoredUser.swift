import RealmSwift

class StoredUser: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var isAuthorized: Bool = false
    
    override class func primaryKey() -> String? {
        return "email"
    }
}
