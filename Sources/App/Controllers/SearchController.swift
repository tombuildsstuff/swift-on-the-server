import Foundation
import HTTP
import Vapor

public final class SearchController {
    
    public static func search(request: Request) throws -> ResponseRepresentable {
        guard let term = request.query?["term"]?.string else {
            return Response(status: .badRequest)
        }
        
        let searchResults = SearchService.search(searchTerm: term)
        let json = try searchResults.toJson()
        return try Response(status: .ok, json: json)
    }
    
}
