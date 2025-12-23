//
//  TodoRepository.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//
//MARK: protocol besically work ase an abstract class
protocol TodoRepository{
    func fetchTodos() async throws -> [Todo]
    func createTodo(title: String) async throws -> Todo
    func updateTodo(todo: Todo) async throws -> Todo
    func deleteTodo(id: Int) async throws
}
