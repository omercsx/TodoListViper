//
//  TaskListPresenterProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

protocol TaskListPresenterProtocol: AnyObject {
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorInputProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    
    func fetchTaskList()
    func fetchTaskDetail(task: Task)
    func logout()
}
