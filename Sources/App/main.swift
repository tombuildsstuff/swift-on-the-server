import HTTP
import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("/build-stuff") { req in
    return "Hello Build Stuff!"
}

drop.get("/towns") { req in
    let towns = [
        Town(name: "Winchester", country: "England"),
        Town(name: "Vilnius", country: "Lithuania"),
        Town(name: "Kiev", country: "Ukraine"),
        Town(name: "Sienna", country: "Italy"),
        Town(name: "Taormina", country: "Sicily"),
        Town(name: "Bilbao", country: "Spain"),
        Town(name: "Lucca", country: "Italy"),
        Town(name: "Cupertino", country: "America")
    ]
    let json = try towns.map({ (town: Town) -> JSON in
        return try town.toJson()
    })
    return try Response(status: .ok, json: JSON(json))
}

drop.resource("posts", PostController())

drop.run()
