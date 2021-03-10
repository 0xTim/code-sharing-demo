import Foundation

public final class Reminder: Codable {
    public var id: UUID?
    public var title: String
    public var userID: UUID
    
    public init(id: UUID?, title: String, userID: UUID) {
        self.id = id
        self.title = title
        self.userID = userID
    }
}

