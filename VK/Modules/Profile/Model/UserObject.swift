import RealmSwift

class UserObject: Object {
    @Persisted(primaryKey: true) var uid: String
    @Persisted var email: String
    @Persisted var fullName: String
}
