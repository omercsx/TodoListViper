//
//  TaskListInteractorInputProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

protocol TaskListInteractorInputProtocol: AnyObject {
    func fetchTaskList()
    func logout()
    func fetchTaskDetail(task: Task)
}
