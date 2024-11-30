//
//  TaskListRouter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

class TaskListRouter: TaskListRouterProtocol {
    var presenter: TaskListPresenterProtocol?
    
    static func createModule() -> TaskListViewController {
        let view = TaskListViewController()
        let presenter = TaskListPresenter()
        let interactor = TaskListInteractor()
        let router = TaskListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
    
    func navigateToLogin() {
        print("Navigating to login screen")
        // navigate to login screen
        let loginView = LoginRouter.createModule()
        let navigationController = UINavigationController(rootViewController: loginView)
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }
    
    func navigateToTaskDetail(task: Task) {
        print("Navigating to task detail screen for task: \(task.title)")
    }
}
