import Foundation
import BSON
import Vapor
import Fluent

final class Aluno: Model, Content {
    static let schema = "alunos"

    @ID(custom: "id")
    var id: ObjectId?

    @Field(key: "nome")
    var nome: String

    @Field(key: "turno")
    var turno: String

    init() {}

    init(id: ObjectId? = nil, nome: String, turno: String) {
        self.id = id
        self.nome = nome
        self.turno = turno
    }
}
