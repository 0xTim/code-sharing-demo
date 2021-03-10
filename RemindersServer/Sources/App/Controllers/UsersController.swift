import Vapor
import RemindersCore

struct UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersGroup = routes.grouped("api", "users")
        usersGroup.post(use: createHandler)
        usersGroup.get(":userID", use: getHandler)
        usersGroup.get(use: getAllHandler)
        usersGroup.put(":userID", use: updateHandler)
    }
    
    func createHandler(_ req: Request) throws -> EventLoopFuture<RemindersCore.User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user.apiModel() }
    }

    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[RemindersCore.User]> {
        return User.query(on: req.db).all().apiModel()
    }

    func getHandler(_ req: Request) throws -> EventLoopFuture<RemindersCore.User> {
        return User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).apiModel()
    }

    func updateHandler(_ req: Request) throws -> EventLoopFuture<RemindersCore.User> {
        let updateData = try req.content.decode(RemindersCore.User.self)
        return User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { user in
            user.name = updateData.name
            user.username = updateData.name
            user.status = updateData.status
            user.lastUpdated = Date()
            return user.save(on: req.db).map { user.apiModel() }
        }
    }
}
