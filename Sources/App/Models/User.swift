//
//  User.swift
//  App
//
//  Created by Soyl on 2019/3/11.
//
import Vapor
import FluentMySQL

final class User: Content, MySQLModel {
    
    var id: Int?
    var name: String?
    var phone: String?
    var email: String?
    var password: String?
//
//    /// Creates a new `User`.
//    init(id: Int? = nil, title: String) {
//        self.id = id
//        self.phone = title
//    }
}

//// Allows `Todo` to be used as a dynamic migration.
//extension Business: Migration { }

////Allows `Todo` to be encoded to and decoded from HTTP messages.
//extension User: Content { }

//// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension User: Parameter { }
