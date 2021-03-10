import Vapor
//import RemindersCore

struct UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersGroup = routes.grouped("api", "users")
        usersGroup.post(use: createHandler)
        usersGroup.get(":userID", use: getHandler)
        usersGroup.get(use: getAllHandler)
        usersGroup.put(":userID", use: updateHandler)
    }
    
    func createHandler(_ req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }

    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }

    func getHandler(_ req: Request) throws -> EventLoopFuture<User> {
        return User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound))
    }

    func updateHandler(_ req: Request) throws -> EventLoopFuture<User> {
        let updateData = try req.content.decode(User.self)
        return User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).flatMap { user in
            user.name = updateData.name
            user.username = updateData.name
            user.status = updateData.status
            return user.save(on: req.db).map { user }
        }
    }
}
