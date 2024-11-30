//
//  TaskListInteractorOutputProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

protocol TaskListInteractorOutputProtocol: AnyObject {
    func didFetchTaskList(_ taskList: [Task])
    func didLogout()
    func didFetchTaskDetail(_ task: Task)
}
