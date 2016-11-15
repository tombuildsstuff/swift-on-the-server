import JSON

struct SearchResults {
    let term : String
    let results : [Town]
    
    func toJson() throws -> JSON {
        let results = try self.results.map { (town: Town) -> JSON in
            return try town.toJson()
        }
        return try JSON(node: [
            "term": self.term,
            "results": JSON(results),
        ])
    }
}
