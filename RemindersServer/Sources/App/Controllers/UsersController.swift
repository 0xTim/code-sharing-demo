import Vapor
import SharedModels
import FluentSQLite
import Foundation

struct UsersController: RouteCollection {
    func boot(router: Router) throws {
        let usersGroup = router.grouped("api", "users")
        usersGroup.post(use: createHandler)
        usersGroup.get(User.parameter, use: getHandler)
        usersGroup.get(use: getAllHandler)
    }
    
    func createHandler(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<User> {
        return try flatMap(to: User.self, req.parameters.next(User.self), req.content.decode(User.self)) { user, updateData in
            user.name = updateData.name
            user.username = updateData.name
            user.status = updateData.status
            user.lastUpdated = Date()
            return user.save(on: req)
        }
    }
}
