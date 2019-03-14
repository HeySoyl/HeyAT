import Vapor
import Fluent
import Crypto
import FluentMySQL

class BusinessController: RouteCollection {
    
    let GetSuccess = "查询成功"
    let GetFailed = "查询失败"
    let SaveSuccess = "保存成功"
    let SaveFailed = "保存失败"
    let IdNotNil = "ID不能为空"
    let DeleteSuccess = "删除成功"
    let NoID = "ID不存在"
    
    //定义接口
    func boot(router: Router) throws {
        router.group("businesses"){ group in
            group.post("select", use: self.select)
            group.post("create", use: self.create)
            group.patch("update", use: self.update)
            group.delete("delete", use: self.delete)
        }
    }
    
    /// 查询业务表信息
    func select(_ req: Request) throws -> Future<Response>{
        return try req.content.decode(Business.self).flatMap { business in
            
            let businessID = business.id
            //不带有ID则查询全部数据
            guard businessID != nil else {
                return Business.query(on: req)
                    .all()
                    .flatMap({
                        content in
                        return try ResponseJSON<[Business]>(status: 0, message: self.GetSuccess, data: content).encode(for: req)
                    })
            }
            //带有ID则查询单条数据
            return Business.query(on: req)
                .filter(\.id == businessID)
                .all()
                .flatMap({
                    content in
                    return try ResponseJSON<[Business]>(status: 0, message: self.GetSuccess, data: content).encode(for: req)
                })
        }
    }
    
    ///创建业务表信息
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Business.self).flatMap { business in
            return business.save(on: req).flatMap({
                content in
                return try ResponseJSON<[Empty]>(status: 0, message: self.SaveSuccess).encode(for: req)
            })
        }
    }
    
    ///修改业务表信息
    func update(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Business.self).flatMap { business in
        
            if business.id == nil {
               return try ResponseJSON<[Empty]>(status: 1021, message: self.IdNotNil).encode(for: req)
            } else {
                return business.update(on: req, originalID: business.id).flatMap({
                    content in
                    return try ResponseJSON<[Empty]>(status: 0, message: self.SaveSuccess).encode(for: req)
                })
            }
        }
    }
    
    /// 删除表信息
    func delete(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Business.self).flatMap { business in
            
            guard business.id != nil else {
                return try ResponseJSON<[Empty]>(status: 1021, message: self.IdNotNil).encode(for: req)
            }
            
            return Business.query(on: req)
                .filter(\.id == business.id)
                .first()
                .flatMap({  content in
                    if content == nil{
                      return try ResponseJSON<[Empty]>(status: 1022, message: self.NoID).encode(for: req)
                    } else {
                        return business.delete(on: req).flatMap({
                            content in
                            return try ResponseJSON<[Empty]>(status: 0, message: self.DeleteSuccess).encode(for: req)
                        })
                    }
                })
        }
    }
}
