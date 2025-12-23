//
//  TodoTDO.swift
//  Clean Arc with MVVM
//
//  Created by Rahat Akash on 23/12/25.
//
//MARK means Data to object

struct TodoDTO: Codable{
    let id: Int
    let title: String
    let completed: Bool
}


extension TodoDTO {
    func toDomain()-> Todo{
        Todo(id: id, title: title, isCompleted: completed)
    }
}

extension Todo {
    func toDTO()-> TodoDTO{
        TodoDTO(id: id, title: title, completed: isCompleted)
    }
}
