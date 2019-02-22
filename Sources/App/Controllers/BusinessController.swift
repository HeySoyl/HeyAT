import Vapor

/// Controls basic CRUD operations on `Todo`s.
struct BusinessController {
    /// Returns a list of all `Business`s.
    func index(_ req: Request) throws -> Future<[Business]> {
        return Business.query(on: req).all()
    }

    /// Saves a decoded `Business` to the database.
    func create(_ req: Request) throws -> Future<Business> {
        return try req.content.decode(Business.self).flatMap { business in
            return business.save(on: req)
        }
    }

    /// Deletes a parameterized `Business`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Business.self).flatMap { business in
            return business.delete(on: req)
        }.transform(to: .ok)
    }
}
