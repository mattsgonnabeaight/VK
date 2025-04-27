import Foundation
import FirebaseAuth

class ProfileViewModel {
    var username: String = "User"

    func fetchUserProfile() {
        if let currentUser = Auth.auth().currentUser {
            self.username = currentUser.email ?? "No Email"
        } else {
            self.username = "No User"
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
