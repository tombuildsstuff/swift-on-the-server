class SearchService {
    
    static func search(searchTerm: String) -> SearchResults {
        let towns = TownsService.all()
        let results = towns.filter { (town: Town) -> Bool in
            let lowerCaseSearchTerm = searchTerm.lowercased()
            
            let lowerCaseName = town.name.lowercased()
            let lowerCaseCountry = town.country.lowercased()
            
            return lowerCaseName.contains(lowerCaseSearchTerm) || lowerCaseCountry.contains(lowerCaseSearchTerm)
        }
        
        return SearchResults(term: searchTerm, results: results)
    }
    
}
