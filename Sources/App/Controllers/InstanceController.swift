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
        router.group("Instgances"){ group in
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
                    .flatMap({  content in
                    return try ResponseJSON<[Instance]>(status: 0, message: "查询成功", data: content).encode(for: req)
                    })
            } else if ibusinessID != nil {
                return Instance.query(on: req)
                    .filter(\.businessID == ibusinessID)
                    .all()
                    .flatMap({  content in
                        return try ResponseJSON<[Instance]>(status: 0, message: "查询成功", data: content).encode(for: req)
                    })
            } else {
                return Instance.query(on: req)
                    .all()
                    .flatMap({  content in
                        return try ResponseJSON<[Instance]>(status: 0, message: "查询成功", data: content).encode(for: req)
                    })
            }
        }
    }
    
    ///创建业务表信息
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Instance.self).flatMap { instance in
            instance.createdAt = Date()
            return instance.save(on: req).flatMap({  content in
                return try ResponseJSON<[Empty]>(status: 0, message: "创建成功").encode(for: req)
            })
        }
    }
    
}
