//
//  TaskListPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

protocol TaskListPresenterDelegate: AnyObject {
    func didFetchTaskList(_ taskList: [Task])
}

protocol TaskListPresenterProtocol: AnyObject {
    var delegate: TaskListPresenterDelegate? { get set }
    var interactor: TaskListInteractorInputProtocol { get set }
    var router: MainRouterProtocol? { get set }
    
    func fetchTaskList()
    func fetchTaskDetail(taskId: Int)
    func addTask(_ task: Task)
    func logout()
}

class TaskListPresenter: TaskListPresenterProtocol {
    
    weak var delegate: TaskListPresenterDelegate?
    var interactor: TaskListInteractorInputProtocol
    var router: MainRouterProtocol?
    
    init(router: MainRouterProtocol? = nil) {
        self.interactor = TaskListInteractor()
        self.router = router
    }
    
    func fetchTaskList() {
        let tasklist = interactor.fetchTaskList()
        delegate?.didFetchTaskList(tasklist)
    }
    
    func logout() {
        router?.logout()
    }
    
    func fetchTaskDetail(taskId: Int) {
        let task = interactor.fetchTask(withId: taskId)
        router?.goToDetail(of: task)
    }
    
    func addTask(_ task: Task) {
        interactor.addTask(task)
    }
    
    // MARK: - Presenter Managing
    func getViewController() -> UIViewController {
        let viewController = TaskListViewController(presenter: self)
        return viewController
    }
}
