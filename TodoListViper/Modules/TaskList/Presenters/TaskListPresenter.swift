//
//  TaskListPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

class TaskListPresenter: TaskListPresenterProtocol {
    weak var view: TaskListViewProtocol?
    var interactor: TaskListInteractorInputProtocol?
    var router: TaskListRouterProtocol?
    
    func fetchTaskList() {
        interactor?.fetchTaskList()
    }
    
    func logout() {
        interactor?.logout()
    }
    
    func fetchTaskDetail(task: Task) {
        print("Task detail fetched: \(task.title)")
    }
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    func didFetchTaskList(_ taskList: [Task]) {
        view?.showTaskList(taskList)
    }
    
    func didLogout() {
        router?.navigateToLogin()
    }
    
    func didFetchTaskDetail(_ task: Task) {
//        view?.fetchTaskDetail(task: task)
        print("Task detail fetched: \(task.title)")
    }
}
