import FluentSQLite
import Vapor
import SharedModels

extension Reminder: SQLiteModel {}
extension Reminder: Migration {
    public static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return Database.create(self, on: conn) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}
extension Reminder: Content {}
extension Reminder: Parameter {}

extension User: SQLiteUUIDModel {}
extension User: Migration {}
extension User: Content {}
extension User: Parameter {}
