import RealmSwift

final class RealmUserManager {
    
    static let shared = RealmUserManager()
    private init() {}

    func saveAuthorizedUser(email: String) {
        let realm = try! Realm()
        let user = StoredUser()
        user.email = email
        user.isAuthorized = true
        
        try! realm.write {
            realm.add(user, update: .modified)
        }
    }
    
    func logoutUser(email: String) {
        let realm = try! Realm()
        if let user = realm.object(ofType: StoredUser.self, forPrimaryKey: email) {
            try! realm.write {
                user.isAuthorized = false
            }
        }
    }

    func getAuthorizedUser() -> StoredUser? {
        let realm = try! Realm()
        return realm.objects(StoredUser.self).filter("isAuthorized == true").first
    }
}
