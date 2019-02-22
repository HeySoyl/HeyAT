import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // Configure a MySQL database
    var databases =  DatabasesConfig()

    let mysqlHost: String
    let mysqlPort: Int
    let mysqlDB: String
    let mysqlUser: String
    let mysqlPass: String
    
    if env == .development || env == .testing {
        mysqlHost = "127.0.0.1"
        mysqlPort = 3306
        mysqlDB = "vapor"
        mysqlUser = "root"
        mysqlPass = "qiqi.loveAI001"
    }
    else {
//        mysqlHost = Environment.get("MYSQL_HOST")!
//        mysqlPort = 3306
//        mysqlDB = Environment.get("MYSQL_DB")!
//        mysqlUser = Environment.get("MYSQL_USER")!
//        mysqlPass = Environment.get("MYSQL_PASS")!
        mysqlHost = Environment.get("MYSQL_HOST") ?? "127.0.0.1"
        mysqlPort = 3306
        mysqlDB = Environment.get("MYSQL_DB") ?? "vapor"
        mysqlUser = Environment.get("MYSQL_USER") ?? "root"
        mysqlPass = Environment.get("MYSQL_PASS") ?? "qiqi.loveAI001"
    }
    
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: mysqlHost,
        port: mysqlPort,
        username: mysqlUser,
        password: mysqlPass,
        database: mysqlDB,
        transport: .unverifiedTLS)
    
    let mysql = MySQLDatabase(config: mysqlConfig)
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    // Configure migrations
    //注册migrations命令
    //vapor run migrate   执行migrate创建表，并执行seed构建测试数据
    //vapor run revert -all   依照migrate创建表顺序，依次清空表后删除该表
    Business.defaultDatabase = .mysql
    var migrations = MigrationConfig()
    migrations.add(model: Business.self, database: .mysql)
    
    if env == .development {
        migrations.add(migration: BusinessSeeder.self, database: .mysql)
    }
    services.register(migrations)

    var commandConfig = CommandConfig.default()
    commandConfig.useFluentCommands()
    services.register(commandConfig)
}
