//
//  RemoteDataSource.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//

import Foundation

final class TodoRemoteDataSource {
//    MARK: use base url
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
//    MARK: fetch or get all the todos
    func fetchTodos() async throws -> [TodoDTO] {
        let url = URL(string: "\(baseURL)/todos")
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        return try JSONDecoder().decode([TodoDTO].self, from: data)
//        return [
//            TodoDTO(id: 1, title: "Learn Swift", completed: false),
//            TodoDTO(id: 2, title: "Build an app", completed:  true),
//        ]
    }
    
//    MARK: create new todo with title
    
    func createTodo(title: String) async throws -> TodoDTO {
        let newTodo = TodoDTO(id: 20, title: title, completed: false)
        
        var request = URLRequest(url: URL(string: "\(baseURL)/todos")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try JSONEncoder().encode(newTodo)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(TodoDTO.self, from: data)
        
    }
    
//    MARK: update todo
    
    func updateTodo(todo: TodoDTO) async throws -> TodoDTO{
        var requset = URLRequest(url: URL(string: "\(baseURL)/todos/\(todo.id)")!)
        requset.httpMethod = "PUT"
        requset.addValue("application/json", forHTTPHeaderField: "Content-type")
        requset.httpBody = try JSONEncoder().encode(todo)
        let (data, _) = try await URLSession.shared.data(for: requset)
        return try JSONDecoder().decode(TodoDTO.self, from: data)
    }
    
//    MARK: delete todo
    
    func deleteTodo(id: Int) async throws {
        var request = URLRequest(url: URL(string: "\(baseURL)/todos/\(id)")!)
        request.httpMethod = "DELETE"
        _ = try await URLSession.shared.data(for: request)
    }
}
