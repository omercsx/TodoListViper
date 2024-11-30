//
//  TaskListRouterProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

protocol TaskListRouterProtocol: AnyObject {
    func navigateToLogin()
    func navigateToTaskDetail(task: Task)
}
