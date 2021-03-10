import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "status")
    var status: String

    @Field(key: "lastUpdated")
    var lastUpdated: Date?

    init() { }

    init(id: UUID? = nil, name: String, username: String, password: String, status: String) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
        self.status = status
    }
}
