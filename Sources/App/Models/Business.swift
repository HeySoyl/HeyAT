//
//  Business.swift
//  App
//
//  Created by Soyl on 2019/2/23.
//

import Vapor
import FluentMySQL

struct Business: Content, MySQLModel {
    
    var id: Int?
    var name: String?
    var desc: String?
    var rediskey: String?
    
    init(id: Int?, name: String?, desc: String?, rediskey: String?) {
        self.id = id
        self.name = name
        self.desc = desc
        self.rediskey = rediskey
    }
    
    init(name: String?, desc: String?, rediskey: String?) {
        self.init(id: nil, name: name, desc: desc, rediskey: rediskey)
    }
    
}

//// Allows `Todo` to be used as a dynamic migration.
//extension Business: Migration { }

////Allows `Todo` to be encoded to and decoded from HTTP messages.
//extension Business: Content { }

//// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Business: Parameter { }
