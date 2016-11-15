import Vapor

let drop = Droplet()

let townsController = TownsController()
let searchController = SearchController()

drop.get { _ in
    return "Hello World"
}

drop.get("/towns", String.self, handler: townsController.single)
drop.get("/towns", handler: townsController.all)

drop.get("/search", handler: searchController.search)

drop.run()
