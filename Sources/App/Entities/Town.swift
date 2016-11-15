import JSON

struct Town {
    
    let name: String
    let country: String
    
    func toJson() throws -> JSON {
        return try JSON(node: [
            "name": self.name,
            "country": self.country,
        ])
    }

}
