import Vapor
import RemindersCore
import Fluent

struct RemindersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let remindersGroup = routes.grouped("api", "reminders")
        remindersGroup.post(use: createHandler)
        remindersGroup.get(use: getAllHandler)
        remindersGroup.get(":reminderID", use: getHandler)
    }

    // Create
    func createHandler(_ req: Request) throws -> EventLoopFuture<RemindersCore.Reminder> {
        let reminder = try req.content.decode(RemindersCore.Reminder.self)
        let fluentReminder = Reminder(title: reminder.title, userID: reminder.userID)
        return fluentReminder.create(on: req.db).map { fluentReminder.apiModel() }
    }

    // Get all
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[RemindersCore.Reminder]> {
        Reminder.query(on: req.db).all().apiModel()
    }

    // Get single
    func getHandler(_ req: Request) throws -> EventLoopFuture<RemindersCore.Reminder> {
        Reminder.find(req.parameters.get("reminderID"), on: req.db).unwrap(or: Abort(.notFound)).apiModel()
    }
}

