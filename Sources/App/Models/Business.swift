import FluentMySQL
import Vapor

/// A single entry of a Todo list.
struct Business: Content, MySQLModel {

    var id: Int?
    var name: String
    var desc: String
    var redis_key: String

    /// Creates a new `Business`.
    init(id: Int? = nil, name: String, desc: String, redis_key: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.redis_key = redis_key
    }
    
//    init(id: Int?, name: String, desc: String, redis_key: String) {
//        self.id = id
//        self.name = name
//        self.desc = desc
//        self.redis_key = redis_key
//    }
//
//    init(name: String, desc: String, redis_key: String) {
//        self.init(id: nil, name: name, desc: desc, redis_key: redis_key)
//    }
}

//// Allows `Todo` to be used as a dynamic migration.
//extension Business: Migration { }

////Allows `Todo` to be encoded to and decoded from HTTP messages.
//extension Business: Content { }

//// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Business: Parameter { }
