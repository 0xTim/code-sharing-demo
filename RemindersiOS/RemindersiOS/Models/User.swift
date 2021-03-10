import Foundation

public final class User: Codable {
    public var id: UUID?
    public var name: String
    public var username: String
    public var status: String
    
    public init(id: UUID?, name: String, username: String, status: String) {
        self.id = id
        self.name = name
        self.username = username
        self.status = status
    }
}
