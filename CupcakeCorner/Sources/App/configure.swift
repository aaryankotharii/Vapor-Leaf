import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let directoryConfig = DirectoryConfiguration.detect()
    app.databases.use(.sqlite(.file("\(directoryConfig.workingDirectory)cupcakes.db")), as: .sqlite)

    
    app.migrations.add(CreateCupcake())
    app.migrations.add(CreateOrder())
    try app.autoMigrate().wait()
    
    app.views.use(.leaf)
    
    try routes(app)
}


