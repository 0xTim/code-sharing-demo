import RemindersCore
import FluentSQLite

struct DefaultUsers: SQLiteMigration {
    
    static func prepare(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        let user1 = User(id: nil, name: "Admin", username: "admin", status: "Controlling the system")
        let user2 = User(id: nil, name: "Tim", username: "timc", status: "Preparing for a talk")
        let user3 = User(id: nil, name: "Alice", username: "alice", status: "Learning Vapor")
        let user4 = User(id: nil, name: "Bob", username: "bob", status: "Destorying Node JS")
        
        let results = [
            user1.save(on: conn),
            user2.save(on: conn),
            user3.save(on: conn),
            user4.save(on: conn)
        ]
        
        return results.flatten(on: conn).transform(to: ())
    }
    
    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return .done(on: conn)
    }
}
