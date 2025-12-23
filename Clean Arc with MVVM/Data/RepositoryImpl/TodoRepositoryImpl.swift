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
        let dtos = try await remoteDataSource.fetchTodos()
        return dtos.map {$0.toDomain()}
    }
}

