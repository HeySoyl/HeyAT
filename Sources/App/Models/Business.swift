import FluentMySQL
import Vapor

struct Business: Content, MySQLModel {

    var id: Int?
    var name: String?
    var desc: String?
    var rediskey: String?
    
    init(id: Int?, name: String?, desc: String?, rediskey: String?) {
        self.id = id
        self.name = name
        self.desc = name
        self.rediskey = name
    }

    init(name: String?, desc: String?, rediskey: String?) {
        self.init(id: nil, name: name,desc: desc,rediskey: rediskey)
    }
    
}

//// Allows `Todo` to be used as a dynamic migration.
//extension Business: Migration { }

////Allows `Todo` to be encoded to and decoded from HTTP messages.
//extension Business: Content { }

//// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Business: Parameter { }
