import Vapor
import Leaf
import FluentSQLiteDriver

func routes(_ app: Application) throws {
    
    app.get {  req -> EventLoopFuture<View> in
        let cupcakes = Cupcake.query(on: req.db).all()
        let orders = Order.query(on: req.db).all()
        
        struct PageData: Codable {
            var cupcakes: [Cupcake]
            var orders : [Order]
        }
        
        return cupcakes.and(orders).flatMap { (cakes,order) -> EventLoopFuture<View> in
            let context = PageData(cupcakes: cakes, orders: order)
            return req.leaf.render("home", context)
        }
//        return Cupcake.query(on: req.db).all().flatMap { cupcakes -> EventLoopFuture<View> in
//            return req.leaf.render("home", ["cupcakes":cupcakes])
//        }
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
    
    app.post("order") { req -> EventLoopFuture<Order> in
        let order = try req.content.decode(Order.self)
        order.date = Date()
        return order.save(on: req.db).map{ order }
    }
}


