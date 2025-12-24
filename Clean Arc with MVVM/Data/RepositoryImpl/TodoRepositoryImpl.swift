//
//  TodoRepositoryImpl.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//

final class TodoRepositoryImple: TodoRepository{
    private let remoteDataSource : TodoRemoteDataSource
    
    init(remoteDataSource: TodoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchTodos() async throws -> [Todo] {
        try await remoteDataSource.fetchTodos().map{ $0.toDomain()}
    }
    
    func createTodo(title: String) async throws -> Todo {
        try await remoteDataSource.createTodo(title: title).toDomain()
    }
    
    func updateTodo(todo: Todo) async throws -> Todo{
        try await remoteDataSource.updateTodo(todo: todo.toDTO()).toDomain()
    }
    
    func deleteTodo(id: Int) async throws {
        try await remoteDataSource.deleteTodo(id: id)
    }
}

