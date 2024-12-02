//
//  TaskListInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

protocol TaskListInteractorInputProtocol: AnyObject {
    func fetchTaskList()
    func logout()
    func fetchTaskDetail(task: Task)
}

class TaskListInteractor: TaskListInteractorInputProtocol {
    weak var presenter: TaskListInteractorOutputProtocol?
    
    let taskList = [
        Task(title: "Task 1", description: "Description 1", isCompleted: false),
        Task(title: "Task 2", description: "Description 2", isCompleted: true),
        Task(title: "Task 3", description: "Description 3", isCompleted: false)
    ]
    
    func fetchTaskList() {
        presenter?.didFetchTaskList(taskList)
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        presenter?.didLogout()
    }
    
    func fetchTaskDetail(task: Task) {
        
        presenter?.didFetchTaskDetail(task)
    }
}
