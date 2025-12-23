//
//  GetTodoUseCase.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//
//MARK: Get todo
final class GetTodoUseCase{
    private let repository:TodoRepository
    
    init(repository: TodoRepository){
        self.repository = repository
    }
    
    func execute() async throws -> [Todo] {
        try await repository.fetchTodos()
    }
}

//MARK: Create todo
final class CreateTodoUseCase{
    private let repository:TodoRepository
    
    init(repository: TodoRepository){
        self.repository = repository
    }
    
    func execute(title: String) async throws -> Todo{
        try await repository.createTodo(title: title)
    }
}

//MARK: Update todo

final class UpdateTodoUseCase{
    private let repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func execute(todo: Todo) async throws-> Todo{
        try await repository.updateTodo(todo: todo)
    }
}

//MARK: delete todo

final class DeleteTodoUseCase{
    private let repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func execute(todo: Todo) async throws{
        try await repository.deleteTodo(id: todo.id)
    }
}
