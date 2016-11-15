import Vapor

let drop = Droplet()

drop.get { _ in
    return "Hello World"
}

drop.get("/towns", String.self, handler: TownsController.single)
drop.get("/towns", handler: TownsController.all)

drop.get("/search", handler: SearchController.search)

drop.run()
