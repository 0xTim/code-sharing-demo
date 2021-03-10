import Foundation

public final class User: Codable {
    public var id: UUID?
    public var name: String
    public var username: String
    public var status: String
    public var lastUpdated: Date?
    
    public init(id: UUID?, name: String, username: String, status: String, lastUpdated: Date? = nil) {
        self.id = id
        self.name = name
        self.username = username
        self.status = status
        self.lastUpdated = lastUpdated
    }
}
