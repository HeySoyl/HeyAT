//
//  InstanceController.swift
//  App
//
//  Created by Soyl on 2019/2/26.
//

import Vapor
import Fluent
import Crypto
import FluentMySQL

class InstanceController: RouteCollection {
    //定义接口
    func boot(router: Router) throws {
        router.group("Instgances"){
            group in
            group.post("select", use: self.select)
            group.post("create", use: self.create)
//            group.patch("update", use: self.create)
//            group.delete("delete", use: self.delete)
        }
    }
    
    /// 查询业务表信息
    func select(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(Instance.self).flatMap { instance in
            let instanceID = instance.id
            let ibusinessID = instance.businessID
            
            if instanceID != nil {
                return Instance.query(on: req)
                    .filter(\.id == instanceID)
                    .all()
                    .encode(status: .created, for: req)
            } else if ibusinessID != nil {
                return Instance.query(on: req)
                    .filter(\.businessID == ibusinessID)
                    .all()
                    .encode(status: .created, for: req)
            } else {
                return Instance.query(on: req)
                    .all()
                    .encode(status: .created, for: req)
            }
        }
    }
    
    ///创建业务表信息
    func create(_ req: Request) throws -> Future<Instance> {
        return try req.content.decode(Instance.self).flatMap { forum in
            return forum.save(on: req)
        }
    }
}
