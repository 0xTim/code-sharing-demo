import Vapor
import RemindersCore

extension RemindersCore.User: Content {}
extension RemindersCore.Reminder: Content {}

extension User: APIModelRepresentable {
    func apiModel() -> RemindersCore.User {
        RemindersCore.User(id: self.id, name: self.name, username: self.username, status: self.status, lastUpdated: self.lastUpdated)
    }
}

extension Reminder: APIModelRepresentable {
    func apiModel() -> RemindersCore.Reminder {
        RemindersCore.Reminder(id: self.id, title: self.title, userID: self.$user.id)
    }
}
