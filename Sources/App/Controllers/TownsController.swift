import Foundation
import HTTP
import Vapor

public final class TownsController {
    
    let townsService: TownsService
    
    init(app: Droplet) {
        self.townsService = TownsService(app: app)
    }
    
    public func all(request: Request) throws -> ResponseRepresentable {
        let towns = try self.townsService.all().map { (town: Town) -> JSON in
            return try town.toJson()
        }
        return JSON(towns)
    }
    
    public func single(request: Request, name: String) throws -> ResponseRepresentable {
        
        guard let town = try self.townsService.byName(name: name) else {
            return Response(status: .notFound)
        }
        
        let json = try town.toJson()
        return Response(status: .ok, body: json)
    }
    
    public func create(request: Request) throws -> ResponseRepresentable {
        guard let name = request.formURLEncoded?["name"]?.string,
            let country = request.formURLEncoded?["country"]?.string else {
                return Response(status: .badRequest)
        }
        
        try self.townsService.create(name: name, country: country)
        return Response(status: .ok)
    }
    
}
