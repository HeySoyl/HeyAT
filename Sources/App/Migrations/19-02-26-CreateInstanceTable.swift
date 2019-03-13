//
//  19-02-26-CreateInstanceTable.swift
//  App
//
//  Created by Soyl on 2019/2/26.
//

import Foundation
import Fluent
import FluentMySQL

extension Instance: Migration {
    static func prepare( on connection: MySQLConnection ) -> Future<Void>
    {
        return Database.create(Instance.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert( on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(Instance.self, on: connection)
    }
}
