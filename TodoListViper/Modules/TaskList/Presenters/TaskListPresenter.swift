//
//  TaskListPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit
import Combine

protocol TaskListPresenterDelegate: AnyObject {
    
}

protocol TaskListPresenterProtocol: AnyObject {
    var delegate: TaskListPresenterDelegate? { get set }
    var interactor: TaskListInteractorInputProtocol { get set }
    var router: MainRouterProtocol? { get set }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    func fetchTaskList()
    func fetchTaskDetail(taskId: Int)
    func addTask(_ task: TodoTask)
    func logout()
}

class TaskListPresenter: TaskListPresenterProtocol {
    
    @Published var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    weak var delegate: TaskListPresenterDelegate?
    var interactor: TaskListInteractorInputProtocol
    var router: MainRouterProtocol?
    var dataSource: DataSourceManaging?
    
    init(router: MainRouterProtocol? = nil) {
        self.interactor = TaskListInteractor()
        self.router = router
    }
    
    func fetchTaskList() {
        isLoading = true
        interactor.fetchTaskList { [weak self]
            tasks, error in
            self?.isLoading = false
            
            if let tasks {
                self?.dataSource?.setItems(items: tasks)
            }
            //Todo: handle error
        }
        
    }
    
    func logout() {
        router?.logout()
    }
    
    func fetchTaskDetail(taskId: Int) {
        isLoading = true
        interactor.fetchTask(withId: taskId) { [weak self]
            taskDetail, error in
            
            self?.isLoading = false
            
            if let taskDetail {
                self?.router?.goToDetail(of: taskDetail)
            }
        }
    }
    
    func addTask(_ task: TodoTask) {
        
        isLoading = true
        interactor.addTask(task) { [weak self]
            success, error in
            
            self?.isLoading = false
            
            guard let self else { return }
            
            if success {
                self.dataSource?.addItem(item: task)
            }
            //Also handle error and show error to user
        }
    }
    
    // MARK: - Presenter Managing
    func getViewController() -> UIViewController {
        let dataSource = TaskListDataSource()
        let viewController = TaskListViewController(presenter: self)
        
        self.dataSource = dataSource
        viewController.setDataSource(dataSource: dataSource)
        return viewController
    }
}
