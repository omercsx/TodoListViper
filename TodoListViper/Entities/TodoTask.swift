//
//  Task.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import Foundation

//Never name a type similar to native types
//"Task" is already a type in iOS
struct TodoTask: Storable {
    var id: String
    let title: String
    let description: String
    let isCompleted: Bool
    var completionDate: Date?
}
