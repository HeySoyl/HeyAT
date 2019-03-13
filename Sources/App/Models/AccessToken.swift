//
//  AccessToken.swift
//  App
//
//  Created by Soyl on 2019/3/12.
//

import Vapor
import FluentMySQL
import Crypto

final class AccessToken: MySQLModel {
    
    var id: Int?
    
    private(set) var token: String
    private(set) var userID: Int
    let expiryTime: Date
    
    static let accessTokenExpirationInterval: TimeInterval = 60 * 60 * 24 * 30 // 1个月
    
    init(userID: Int) throws {
        self.token = try CryptoRandom().generateData(count: 32).base64URLEncodedString()
        self.userID = userID
        self.expiryTime = Date().addingTimeInterval(AccessToken.accessTokenExpirationInterval)
    }
    
}



//extension AccessToken: Migration { }
//
extension AccessToken: Content { }

extension AccessToken: Parameter { }
