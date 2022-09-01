import Foundation

struct User {
    let login: String
    let id: Int
    let avatarURL: String
    let url: String
}

extension User{
    var profileViewed:Bool{PersistenceManager.profileViewed(for: Int32(id))}
    var hasNote:Bool{PersistenceManager.hasNote(for: Int32(id))}
    var note:String{PersistenceManager.note(for: Int32(id))}
}
