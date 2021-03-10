import Fluent

struct DefaultReminders: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        User.query(on: database).first().flatMap { user in
            guard let userID = user?.id else {
                return database.eventLoop.future()
            }
            
            let reminder1 = Reminder(id: nil, title: "Finish Vapor book", userID: userID)
            let reminder2 = Reminder(id: nil, title: "Write presentation", userID: userID)
            let reminder3 = Reminder(id: nil, title: "Remember how much I dislike Cocoapods", userID: userID)
            let reminder4 = Reminder(id: nil, title: "Take over the world with Server-side Swift", userID: userID)
            
            let reminders = [
                reminder1,
                reminder2,
                reminder3,
                reminder4
            ]
            
            return reminders.create(on: database)
        }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        Reminder.query(on: database).delete()
    }
}
