//
//  BusinessSeeder.swift
//  App
//
//  Created by Soyl on 2019/2/21.
//

import Vapor
import Fluent
import Foundation
import FluentMySQL

struct BusinessSeeder: Migration {
    typealias Database = MySQLDatabase
    
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        return [1, 2, 3, 4, 5, 6]
            .map { i in
                Business(name: "Business name:\(i)", desc: "Business desc:\(i)", rediskey: "Business rediskey:\(i)")
            }
            .map { $0.save(on: connection) }
            .flatten(on: connection)
            .transform(to: ())
    }
    static func revert(on conn: Database.Connection) -> Future<Void> {
        return conn.query("truncate table `Business`").transform(to: Void())
    }
}
