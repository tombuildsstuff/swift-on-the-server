import Foundation
import HTTP
import Vapor

public final class TownsController {
    
    public func all(request: Request) throws -> ResponseRepresentable {
        let towns = try TownsService.all().map { (town: Town) -> JSON in
            return try town.toJson()
        }
        return JSON(towns)
    }
    
    public func single(request: Request, name: String) throws -> ResponseRepresentable {
        
        guard let town = TownsService.byName(name: name) else {
            return Response(status: .notFound)
        }
        
        let json = try town.toJson()
        return Response(status: .ok, body: json)
    }
    
}
