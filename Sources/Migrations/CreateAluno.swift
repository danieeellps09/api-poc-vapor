import Fluent

struct CreateAluno: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.future()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.future()
    }
}
