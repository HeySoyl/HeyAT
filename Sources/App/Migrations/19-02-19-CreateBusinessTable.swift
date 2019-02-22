//
//  19-02-19-CreateBusinessTable.swift
//  App
//
//  Created by Soyl on 2019/2/19.
//

import Fluent
import FluentMySQL

extension Business: Migration {
    static func prepare( on connection: MySQLConnection ) -> Future<Void>
    {
        return Database.create(Business.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert(
        on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(Business.self, on: connection)
    }
}
