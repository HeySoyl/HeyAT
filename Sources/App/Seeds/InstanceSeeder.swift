//
//  InstanceSeeder.swift
//  App
//
//  Created by Soyl on 2019/2/26.
//

import Vapor
import Fluent
import Foundation
import FluentMySQL

struct InstanceSeeder: Migration {
    typealias Database = MySQLDatabase
    
    static func prepare(on connection: Database.Connection) -> Future<Void> {
        var instanceId = 0
        return [1, 2, 3, 4, 5, 6]
            .flatMap {
                business in
                return [1, 2, 3, 4, 5, 6]
                    .map{
                        instance -> Instance in
                        instanceId += 1
                        
                        return Instance(
                            id: instanceId,
                            name: "Name: Business \(business) Instance name is \(instance)",
                            desc: "Desc: Business \(business) Instance name is \(instance)",
                            businessID: business,
                            createdAt: Date())
                }
            }
            .map { $0.save(on: connection) }
            .flatten(on: connection)
            .transform(to: ())
    }
    
    static func revert(on conn: Database.Connection) -> Future<Void> {
        return conn.query("truncate table `Instance`").transform(to: Void())
    }
}
