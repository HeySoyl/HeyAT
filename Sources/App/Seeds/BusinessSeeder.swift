//
//  BusinessSeeder.swift
//  App
//
//  Created by Soyl on 2019/2/21.
//

import Foundation
import Fluent
import FluentMySQL

struct BusinessSeeder: Migration {
    typealias Database = MySQLDatabase
    
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return [1, 2, 3]
            .map { i in
                Business(name: "name:\(i)", desc: "desc:\(i)", redis_key: "redis_key:\(i)")
            }
            .map { $0.save(on: connection) }
            .flatten(on: connection)
            .transform(to: ())
    }
    static func revert(on conn: Database.Connection) -> Future<Void> {
        return conn.query("truncate table `Business`").transform(to: Void())
    }
}
