//
//  Clean_Arc_with_MVVMApp.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//

import SwiftUI

@main
struct Clean_Arc_with_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            let remote = TodoRemoteDataSource()
            let repo = TodoRepositoryImple(remoteDataSource: remote)
            
            ContentView(viewModel: TodoListViewModel(
                getTodos: GetTodoUseCase(repository: repo),
                createTodo: CreateTodoUseCase(repository: repo),
                updateTodo: UpdateTodoUseCase(repository: repo),
                deleteTodo: DeleteTodoUseCase(repository: repo)
            ))
        }
    }
}
