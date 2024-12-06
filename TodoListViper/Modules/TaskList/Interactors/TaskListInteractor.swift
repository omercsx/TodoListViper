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
    func addTask(_ task: Task)
}

class TaskListInteractor: TaskListInteractorInputProtocol {
    var taskList = [
        Task(title: "Task 1", description: "Description 1", isCompleted: false),
        Task(title: "Task 2", description: "Description 2", isCompleted: true, completionDate: .now),
        Task(title: "Task 3", description: "Description 3", isCompleted: false)
    ]
    
    func fetchTaskList() -> [Task] {
        return taskList
    }
    
    func addTask(_ task: Task) {
        taskList.append(task)
    }
    
    func fetchTask(withId id: Int) -> Task {
        return taskList[id]
    }
}
