import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // set staging.db as dB directory
    let directoryConfig = DirectoryConfiguration.detect()
    app.databases.use(.sqlite(.file("\(directoryConfig.workingDirectory)staging.db")), as: .sqlite)

    
    // run migartions for dB
    app.migrations.add(CreateCupcake())
    app.migrations.add(CreateOrder())
    try app.autoMigrate().wait()
    
    // allow app to render HTML using leaf
    app.views.use(.leaf)
    
    try routes(app)
}


