//
//  File.swift
//  
//
//  Created by Daniel Lopes da Silva on 28/08/24.
//

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

    func index(req: Request) throws -> EventLoopFuture<[Aluno]> {
        return Aluno.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Aluno> {
        let aluno = try req.content.decode(Aluno.self)
        return aluno.save(on: req.db).map { aluno }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Aluno.find(req.parameters.get("alunoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { aluno in
                aluno.delete(on: req.db)
            }
            .transform(to: .ok)
    }
}
