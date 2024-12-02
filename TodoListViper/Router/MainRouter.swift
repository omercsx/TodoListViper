//
//  MainRouter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

protocol MainRouterProtocol {
    func start()
    func loginSuccess()
    func logout()
    func goToDetail()
}

class MainRouter: MainRouterProtocol {
    private let appRoot: UIWindow
    private let navigationController: UINavigationController
    
    init(appRoot: UIWindow) {
        self.appRoot = appRoot
        self.navigationController = UINavigationController()
        self.appRoot.rootViewController = navigationController
        self.appRoot.makeKeyAndVisible()
    }
    
    func start() {
        let presenter = LoginPresenter(router: self)

        let vc = presenter.getViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func loginSuccess() {
        let presenter = TaskListPresenter(router: self)
        let taskListVC = presenter.getViewController()
        
        navigationController.pushViewController(taskListVC, animated: true)
    }
    
    func logout() {
        navigationController.popViewController(animated: true)
    }
    
    func goToDetail() {
//        let detailViewController = TaskDetailViewController(task: task)
//        let presenter = TaskDetailPresenter(router: self)
        
        navigationController.pushViewController(TaskDetailViewController(), animated: true)
    }
}
