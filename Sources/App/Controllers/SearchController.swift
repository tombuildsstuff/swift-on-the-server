import Foundation
import HTTP
import Vapor

public final class SearchController {
    
    let searchService: SearchService
    
    init(app: Droplet) {
        self.searchService = SearchService(app: app)
    }
    
    public func search(request: Request) throws -> ResponseRepresentable {
        guard let term = request.query?["term"]?.string else {
            return Response(status: .badRequest)
        }
        
        let searchResults = try self.searchService.search(searchTerm: term)
        let json = try searchResults.toJson()
        return try Response(status: .ok, json: json)
    }
    
}
