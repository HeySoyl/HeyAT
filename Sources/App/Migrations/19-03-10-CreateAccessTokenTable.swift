//
//  19-03-10-CreateAccessTokenTable.swift
//  App
//
//  Created by Soyl on 2019/3/13.
//

import Foundation
import Fluent
import FluentMySQL

extension AccessToken: Migration {
    static func prepare( on connection: MySQLConnection ) -> Future<Void>
    {
        return Database.create(AccessToken.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert( on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(AccessToken.self, on: connection)
    }
}
