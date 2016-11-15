import Vapor

class SearchService {
    
    let townsService: TownsService
    
    init(app: Droplet) {
        self.townsService = TownsService(app: app)
    }
    
    func search(searchTerm: String) throws -> SearchResults {
        let towns = try self.townsService.all()
        let results = towns.filter { (town: Town) -> Bool in
            let lowerCaseSearchTerm = searchTerm.lowercased()
            
            let lowerCaseName = town.name.lowercased()
            let lowerCaseCountry = town.country.lowercased()
            
            return lowerCaseName.contains(lowerCaseSearchTerm) || lowerCaseCountry.contains(lowerCaseSearchTerm)
        }
        
        return SearchResults(term: searchTerm, results: results)
    }
    
}
