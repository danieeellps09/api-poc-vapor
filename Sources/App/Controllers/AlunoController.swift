import Foundation
import Vapor

struct AlunoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let alunosRoute = routes.grouped("alunos")
        alunosRoute.get(use: index)
        alunosRoute.post(use: create)
        alunosRoute.group(":alunoID") { aluno in
            aluno.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Aluno] {
        return try await Aluno.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Aluno {
        let aluno = try req.content.decode(Aluno.self)
        try await aluno.save(on: req.db)
        return aluno
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let aluno = try await Aluno.find(req.parameters.get("alunoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await aluno.delete(on: req.db)
        return .ok
    }
}
