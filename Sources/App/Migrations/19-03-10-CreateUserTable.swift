//
//  19-03-10-CreateUserTable.swift
//  App
//
//  Created by Soyl on 2019/3/11.
//

import Foundation
import Fluent
import FluentMySQL

extension User: Migration {
    static func prepare( on connection: MySQLConnection ) -> Future<Void>
    {
        return Database.create(User.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert( on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(User.self, on: connection)
    }
}
