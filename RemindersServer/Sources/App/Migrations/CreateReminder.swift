import Fluent

struct CreateReminder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reminders")
            .id()
            .field("title", .string, .required)
            .field("userID", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reminders").delete()
    }
}
