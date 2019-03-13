import Vapor
import Fluent
import Crypto
import FluentMySQL

class BusinessController: RouteCollection {
    
    let GetSuccess = "获取成功"
    let GetFailed = "获取失败"
    let SaveSuccess = "保存成功"
    
    //定义接口
    func boot(router: Router) throws {
        router.group("businesses"){ group in
            group.post("select", use: self.select)
            group.post("create", use: self.create)
            group.patch("update", use: self.create)
            group.delete("delete", use: self.delete)
        }
    }
    
    /// 查询业务表信息
    func select(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(Business.self).flatMap { forum in
            
            let forumID = forum.id
            //不带有ID则查询全部数据
            guard forumID != nil else {
                return Business.query(on: req)
                    .all()
                    .flatMap({
                        content in
                        return try ResponseJSON<[Business]>(status: 0, message: self.GetSuccess, data: content).encode(for: req)
                    })
            }
            //带有ID则查询单条数据
            return Business.query(on: req)
                .filter(\.id == forumID)
                .all()
                .encode(status: .created, for: req)
        }
    }
    
    ///创建业务表信息
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Business.self).flatMap { forum in
            return forum.save(on: req).flatMap({
                content in
                return try ResponseJSON<[Empty]>(status: 0, message: self.SaveSuccess).encode(for: req)
            })
        }
    }
    
    ///修改业务表信息
    func update(_ req: Request) throws -> Future<Business> {
        return try req.content.decode(Business.self).flatMap { forum in
            let forumID = forum.id
            return forum.update(on: req, originalID: forumID)
        }
    }
    
    /// Deletes a parameterized `Business`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Business.self).flatMap { business in
            return business.delete(on: req)
            }.transform(to: .ok)
    }
}
