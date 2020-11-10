//
//  File.swift
//  
//
//  Created by Aaryan Kothari on 10/11/20.
//

import FluentSQLiteDriver
import Fluent
import Foundation
import Vapor

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id) var id: UUID?
    
    @Field(key: "cakeName") var cakeName: String
    
    @Field(key: "buyerName") var buyerName: String
    
    @Field(key: "date") var date: Date?

    init() {}
    
    init(id: UUID? = nil, cakeName: String,buyerName:String,date:Date?=nil) {
        self.id = id
        self.cakeName = cakeName
        self.buyerName = buyerName
        self.date = date
    }
    
}

struct CreateOrder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("orders")
            .id()
            .field("cakeName", .string, .required)
            .field("buyerName", .string, .required)
            .field("date",.date)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("orders").delete()
    }
}
