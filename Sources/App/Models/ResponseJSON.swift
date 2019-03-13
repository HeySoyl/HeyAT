//
//  ResponseJSON.swift
//  App
//
//  Created by Soyl on 2019/3/11.
//

import Vapor

struct Empty: Content {}

struct ResponseJSON<T: Content>: Content {
    private var status: Int
    private var message: String
    private var data: T?
    
    init(status: Int = 0, message: String, data: T?) throws {
        self.status = status
        self.message = message
        self.data = data
    }
    
    init(status: Int = 0, message: String) throws {
        self.status = status
        self.message = message
        self.data = nil
    }
}
