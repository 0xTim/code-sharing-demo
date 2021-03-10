import Fluent

struct DefaultUsers: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let user1 = User(id: nil, name: "Admin", username: "admin", password: "password", status: "Controlling the system")
        let user2 = User(id: nil, name: "Tim", username: "timc", password: "password", status: "Preparing for a talk")
        let user3 = User(id: nil, name: "Alice", username: "alice", password: "password", status: "Learning Vapor")
        let user4 = User(id: nil, name: "Bob", username: "bob", password: "password", status: "Destorying Node JS")

        return [
            user1,
            user2,
            user3,
            user4
        ].create(on: database)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        User.query(on: database).delete()
    }
}
