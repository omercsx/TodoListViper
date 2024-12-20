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
    func goToDetail(of task: TodoTask)
}

class MainRouter: MainRouterProtocol {
    private let appRoot: UIWindow
    private let navigationController: UINavigationController

    init(appRoot: UIWindow) {
        self.appRoot = appRoot
        navigationController = UINavigationController()
        self.appRoot.rootViewController = navigationController
        self.appRoot.makeKeyAndVisible()
    }

    func start() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            loginSuccess()
        } else {
            let presenter = LoginPresenter(router: self)

            let vc = presenter.getViewController()
            navigationController.setViewControllers([vc], animated: false)
        }
    }

    func loginSuccess() {
        let tabPresenter = MainTabBarPresenterPresenter(router: self)
        
        navigationController.setViewControllers([tabPresenter.getViewController()], animated: true)
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        start()
    }

    func goToDetail(of task: TodoTask) {
        navigationController.pushViewController(TaskDetailViewController(task: task), animated: true)
    }
}
