import MySQL
import Vapor

class TownsService {
    
    let app: Droplet
    
    init(app: Droplet) {
        self.app = app
    }
    
    func all() throws -> [Town] {
        let database = try buildDatabase()
        let result = try database.execute("SELECT name, country FROM towns")
        let towns = result.map { (result: [String : Node]) -> Town in
            let name = result["name"]?.string ?? ""
            let country = result["country"]?.string ?? ""
            return Town(name: name, country: country)
        }
        return towns
    }
    
    func byName(name: String) throws -> Town? {
        let towns = try self.all()
        return towns.filter { (town: Town) -> Bool in
            return town.name.lowercased() == name.lowercased()
        }.first
    }
    
    func create(name: String, country: String) throws {
        let database = try self.buildDatabase()
        try database.execute("INSERT INTO towns (name, country) VALUES (?, ?)", [name, country])
    }
    
    private func buildDatabase() throws -> MySQL.Database {
        guard let host = self.app.config["database", "host"]?.string else {
            throw MissingConfigurationValuesError.MissingHost
        }
        
        guard let username = self.app.config["database", "username"]?.string else {
            throw MissingConfigurationValuesError.MissingUsername
        }
        
        guard let password = self.app.config["database", "password"]?.string else {
            throw MissingConfigurationValuesError.MissingPassword
        }
        
        guard let database = self.app.config["database", "database"]?.string else {
            throw MissingConfigurationValuesError.MissingDatabase
        }
        
        return try MySQL.Database(host: host, user: username, password: password, database: database)
    }
    
}

enum MissingConfigurationValuesError : Swift.Error {
    
    case MissingHost, MissingUsername, MissingPassword, MissingDatabase
    
}
