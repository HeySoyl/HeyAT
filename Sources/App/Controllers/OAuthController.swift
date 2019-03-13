//
//  OAuthController.swift
//  App
//
//  Created by Soyl on 2019/3/12.
//

import Vapor
import Fluent
import Crypto
import FluentMySQL

class OAuthController: RouteCollection {
    func boot(router: Router) throws {
        router.group("oauth") { group in
            group.post("regist", use: self.regist)  //注册接口
            group.post("login", use: self.login)    //登陆接口
            group.post("getUserInfo", use: self.getUserInfo)    //获取个人信息
            group.post("setUserInfo", use: self.setUserInfo)    //设置个人信息
            group.post("exit", use: self.exit)      //退出登录
        }
    }
    
    func regist(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(User.self).flatMap { forum in
            
            guard let phone = forum.phone else {
                return try ResponseJSON<Empty>(status: 1001, message: "请输入手机号").encode(for: req)
            }
            
            guard forum.password != nil else {
                return try ResponseJSON<Empty>(status: 1002, message: "请输入密码").encode(for: req)
            }
            
            return User.query(on: req)
                .filter(\.phone, .equal, phone)
                .first()
                .flatMap({  user in
                    guard user != nil else {
                        let result = forum.save(on: req)
                        return result.flatMap({  content in
                            let accessToken = try AccessTokenController.sharedInstance.addToken(content.id!, on: req)
                            return try ResponseJSON<AccessToken>(status: 0, message: "注册成功", data: accessToken).encode(for: req)
                        })
                    }
                    return try ResponseJSON<AccessToken>(status: 1003, message: "手机号已注册").encode(for: req)
            })
        }
    }
    
    func login(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(User.self).flatMap({  content in

            guard let phone = content.phone else {
                return try ResponseJSON<Empty>(status: 1001, message: "请输入手机号").encode(for: req)
            }

            guard let password = content.password else {
                return try ResponseJSON<Empty>(status: 1002, message: "请输入密码").encode(for: req)
            }

            return User.query(on: req)
                .filter(\.phone, .equal, phone)
                .filter(\.password, .equal, password)
                .first()
                .flatMap({  user in
                    guard user != nil else {
                        return try ResponseJSON<Empty>(status: 1004, message: "手机号或者密码错误").encode(for: req)
                    }
                    return try ResponseJSON<Empty>(status: 0, message: "登陆成功").encode(for: req)
                })
        })
    }
    
    // MARK: 获取个人信息
    func getUserInfo(_ req: Request) throws -> Future<Response> {
        
        /********   第二种👋token验证   Request->func(route)->func(getUID)->func(route)->func(getUID)->Response    *******/
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (uid) -> (EventLoopFuture<Response>) in
            // 查找
            return User
                .query(on: req)
                .filter(\.id, .equal, uid)
                .first()
                .flatMap({ user in
                    
                    guard user != nil else{
                        return try ResponseJSON<Empty>(status: 1005, message: "token错误 没有找到这个用户").encode(for: req)
                    }
                    return try ResponseJSON<User>(status: 0, message: "验证成功🌹", data: user).encode(for: req)
                })
        })
    }
    // MARK: 设置个人信息
    func setUserInfo(_ req:Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (uid) -> (EventLoopFuture<Response>) in
            // 查找
            return User
                .query(on: req)
                .filter(\.id, .equal, uid)
                .first()
                .flatMap({ user in
                    
                    guard user != nil else{
                        return try ResponseJSON<Empty>(status: 1005, message: "token错误 没有找到这个用户").encode(for: req)
                    }
                    
                    //获取请求的数据
                    return try req.content.decode(User.self).flatMap({ content in
                        
//                        if content.email != nil  {
//                            user?.email = content.email
//                        }
//                        if content.name != nil  {
//                            user?.name = content.name
//                        }
//                        if content.headImage != nil  {
//                            user?.headImage = content.headImage
//                        }
                        return  user!.update(on: req).flatMap({ content in
                            
                            return try ResponseJSON<User>(status: 0, message: "设置成功", data:content).encode(for: req)
                            
                        })
                        
                    })
                })
        })
    }
    // MARK: 退出登录
    func exit(_ req:Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.exit(req)
        
    }
    
}
