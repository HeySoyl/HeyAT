//
//  Instance.swift
//  App
//
//  Created by Soyl on 2019/2/26.
//

import Vapor
import Fluent
import FluentMySQL

final class Instance: Content, MySQLModel {
    
    var id: Int?
    var name: String?
    var desc: String?
    var businessID: Int?
    var createdAt: Date?

//    init(id: Int?, name: String?, desc: String?, businessID: Int, createdAt: Date?) {
//        self.id = id
//        self.name = name
//        self.desc = desc
//        self.businessID = businessID
//        self.createdAt = Date()
//        print("Model +++ \(Date())")
//    }
//
//    init(name: String?, desc: String?, businessID: Int, createdAt: Date?) {
//        print("Model +++ \(Date())")
//        self.init(id: nil, name: name, desc: desc, businessID: businessID, createdAt: Date())
//    }
    
}

//extension Instance {
//    var business: Parent<Instance, Business> {
//        return parent(\.businessID)
//    }
//}

//// Allows `Todo` to be used as a dynamic migration.
//extension Business: Migration { }

////Allows `Todo` to be encoded to and decoded from HTTP messages.
//extension Business: Content { }

//// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Instance: Parameter { }
