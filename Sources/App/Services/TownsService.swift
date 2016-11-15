class TownsService {
    
    static func all() -> [Town] {
        return [
            Town(name: "Winchester", country: "England"),
            Town(name: "Vilnius", country: "Lithuania"),
            Town(name: "Kiev", country: "Ukraine"),
            Town(name: "Sienna", country: "Italy"),
            Town(name: "Taormina", country: "Sicily"),
            Town(name: "Bilbao", country: "Spain")
        ]
    }
    
    static func byName(name: String) -> Town? {
        let towns = self.all()
        return towns.filter { (town: Town) -> Bool in
            return town.name.lowercased() == name.lowercased()
        }.first
    }
    
}
