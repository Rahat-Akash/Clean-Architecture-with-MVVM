//
//  ContentView.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: TodoListViewModel
    @State private var newTitle: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                addTodoSection
                contentView
            }
            .navigationTitle("Todos")
            .task{
                await viewModel.loadTodos()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)){
                Button("OK"){viewModel.errorMessage = nil}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
    private var addTodoSection: some View {
        HStack{
            TextField("New todo", text: $newTitle)
                .textFieldStyle(.roundedBorder)
            Button("Add"){
                let title = newTitle
                newTitle = ""
                Task { await viewModel.addTodo(title: title)}
            }
            .disabled(newTitle.isEmpty)
        }
        .padding()
    }

    private var contentView: some View{
        Group{
            if viewModel.isLoading{
                ProgressView()
            }else{
                List{
                    ForEach(viewModel.todos){
                        todo in HStack{
                            Text(todo.title)
                            Spacer()
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            Task{
                                await viewModel.toggle(todo: todo)
                            }
                        }
                    }
                    .onDelete{
                        offsets in Task{
                            await viewModel.removeTodo(at: offsets)
                        }
                    }
                }
            }
        }
    }
}




