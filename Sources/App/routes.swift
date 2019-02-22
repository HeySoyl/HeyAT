import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Example of configuring a controller
    let businessController = BusinessController()
    router.get("businesses", use: businessController.index)
    router.post("businesses", use: businessController.create)
    router.delete("businesses", Business.parameter, use: businessController.delete)
    
}
