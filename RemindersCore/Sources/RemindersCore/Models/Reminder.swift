import Foundation

public final class Reminder: Codable {
    public var id: Int?
    public var title: String
    public var userID: UUID
    
    public init(id: Int?, title: String, userID: UUID) {
        self.id = id
        self.title = title
        self.userID = userID
    }
}
