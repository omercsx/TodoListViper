//
//  TaskListInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

protocol TaskListInteractorInputProtocol: AnyObject {
    func fetchTaskList() -> [Task]
    func fetchTask(withId id: Int) -> Task
}

class TaskListInteractor: TaskListInteractorInputProtocol {
    let taskList = [
        Task(title: "Task 1", description: "Description 1", isCompleted: false),
        Task(title: "Task 2", description: "Description 2", isCompleted: true),
        Task(title: "Task 3", description: "Description 3", isCompleted: false)
    ]
    
    func fetchTaskList() -> [Task] {
        return taskList
    }
    
    func fetchTask(withId id: Int) -> Task {
        return taskList[id]
    }
}
