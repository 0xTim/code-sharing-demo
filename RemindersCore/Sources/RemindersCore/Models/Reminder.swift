public final class Reminder: Codable {
    public var id: Int?
    public var title: String
    public var userID: Int
    
    public init(id: Int?, title: String, userID: Int) {
        self.id = id
        self.title = title
        self.userID = userID
    }
}
