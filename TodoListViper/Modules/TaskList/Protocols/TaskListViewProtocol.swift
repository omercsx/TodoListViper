//
//  TaskListViewProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

protocol TaskListViewProtocol: AnyObject {
    func showTaskList(_ taskList: [Task])
    func logoutButtonTapped()
}
