import Vapor
import Leaf
import FluentSQLiteDriver

func routes(_ app: Application) throws {
    
    app.get {  req -> EventLoopFuture<View> in
        return Cupcake.query(on: req.db).all().flatMap { cupcakes -> EventLoopFuture<View> in
            return req.leaf.render("home", ["cupcakes":cupcakes])
        }
    }
    
    app.get("cupcakes") { req -> EventLoopFuture<[Cupcake]> in
        return Cupcake.query(on: req.db).sort("name",.ascending).all()
    }
    
    app.post("add") { req -> EventLoopFuture<Response> in
        let cupcake = try req.content.decode(Cupcake.self)
        return cupcake.create(on: req.db).map { cupcake in
            return req.redirect(to: "/")
        }
    }
}


