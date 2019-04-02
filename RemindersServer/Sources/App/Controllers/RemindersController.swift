import Vapor
import RemindersCore
import FluentSQLite
import Foundation

struct RemindersController: RouteCollection {
    func boot(router: Router) throws {
        let remindersGroup = router.grouped("api", "reminders")
        remindersGroup.post(use: createHandler)
        remindersGroup.get(Reminder.parameter, use: getHandler)
        remindersGroup.get(use: getAllHandler)
    }
    
    func createHandler(_ req: Request) throws -> Future<Reminder> {
        return try req.content.decode(Reminder.self).save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Reminder]> {
        return Reminder.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Reminder> {
        return try req.parameters.next(Reminder.self)
    }
}

