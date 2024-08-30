import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws -> String in
        "It works!"
    }

    let alunoController = AlunoController()
    try app.register(collection: alunoController)
}
