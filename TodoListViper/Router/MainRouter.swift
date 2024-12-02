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
        let taskListViewController = TaskListViewController()
        let interactor = TaskListInteractor()
        let presenter = TaskListPresenter(view: taskListViewController, 
                                        interactor: interactor, 
                                        router: self)
        
        taskListViewController.presenter = presenter
        interactor.presenter = presenter
        
        navigationController.pushViewController(taskListViewController, animated: true)
    }
    
    func logout() {
        navigationController.popViewController(animated: true)
    }
}
