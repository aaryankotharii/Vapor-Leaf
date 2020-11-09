//
//  File.swift
//  
//
//  Created by Aaryan Kothari on 08/11/20.
//

import FluentSQLiteDriver
import Fluent
import Foundation
import Vapor

final class Cupcake: Model, Content {
    static let schema = "cupcakes"
    
    @ID(key: .id) var id: UUID?
    
    @Field(key: "name") var name: String
    
    @Field(key: "description") var description: String
    
    @Field(key: "price") var price: Int

    init() {}
    
    init(id: UUID? = nil, name: String,description:String,price:Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }
    
}

struct CreateCupcake: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("cupcakes")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .int)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("cupcakes").delete()
    }
}



