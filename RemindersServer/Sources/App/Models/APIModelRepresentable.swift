
import Foundation
import Vapor

protocol APIModelRepresentable {
    associatedtype APIModelRepresentationType: Content
    func apiModel() throws -> APIModelRepresentationType
}

// MARK: Convenience Extensions
extension EventLoopFuture where Value: APIModelRepresentable {
    func apiModel() throws -> EventLoopFuture<Value.APIModelRepresentationType> {
        return flatMapThrowing { try $0.apiModel() }
    }
}

extension Array: APIModelRepresentable where Element: APIModelRepresentable {
    typealias APIModelRepresentationType = [Element.APIModelRepresentationType]

    func apiModel() throws -> [Element.APIModelRepresentationType] {
        return try map { try $0.apiModel() }
    }
}
