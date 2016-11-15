import Vapor

let drop = Droplet()

let townsController = TownsController(app: drop)
let searchController = SearchController(app: drop)

drop.get { _ in
    return "Hello World"
}

drop.post("/towns/create", handler: townsController.create)
drop.get("/towns", String.self, handler: townsController.single)
drop.get("/towns", handler: townsController.all)

drop.get("/search", handler: searchController.search)

drop.run()
