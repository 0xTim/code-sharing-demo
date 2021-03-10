import Foundation
import Vapor

protocol APIModelRepresentable {
    associatedtype APIModelRepresentationType: Content
    func apiModel() -> APIModelRepresentationType
}

// MARK: Convenience Extensions
extension EventLoopFuture where Value: APIModelRepresentable {
    func apiModel() -> EventLoopFuture<Value.APIModelRepresentationType> {
        return map { $0.apiModel() }
    }
}

extension Array: APIModelRepresentable where Element: APIModelRepresentable {
    typealias APIModelRepresentationType = [Element.APIModelRepresentationType]

    func apiModel() -> [Element.APIModelRepresentationType] {
        return map { $0.apiModel() }
    }
}
