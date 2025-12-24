//
//  TodoListViewModel.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 24/12/25.
//

import SwiftUI
internal import Combine

@MainActor
final class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let getTodos: GetTodoUseCase
    private let createTodo: CreateTodoUseCase
    private let updateTodo: UpdateTodoUseCase
    private let deleteTodo: DeleteTodoUseCase
    
    init(getTodos: GetTodoUseCase, createTodo: CreateTodoUseCase, updateTodo: UpdateTodoUseCase, deleteTodo: DeleteTodoUseCase) {
        self.getTodos = getTodos
        self.createTodo = createTodo
        self.updateTodo = updateTodo
        self.deleteTodo = deleteTodo
    }
    
    func loadTodos() async{
        isLoading = true
        defer { isLoading = false}
        do {
            todos = try await getTodos.execute()
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func addTodo( title: String) async{
        do{
            let todo = try await createTodo.execute(title: title)
            todos.insert(todo, at: 0)
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func toggle(todo: Todo) async {
        let update = Todo(id: todo.id, title: todo.title, isCompleted: todo.isCompleted)
        do{
            let result = try await updateTodo.execute(todo: update)
            if let index = todos.firstIndex(where: {$0.id == result.id}){
                todos[index] = result
            }
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func removeTodo(at offsets: IndexSet) async{
        for index in offsets{
            let id = todos[index].id
            do{
                try await deleteTodo.execute(id: id)
                todos.remove(at: index)
            }catch{
                errorMessage = error.localizedDescription
            }
        }
    }
}

