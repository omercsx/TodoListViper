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
    private let tabBarController: UITabBarController

    init(appRoot: UIWindow) {
        self.appRoot = appRoot
        navigationController = UINavigationController()
        tabBarController = MainTabBarController()
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
        // Create Home Tab (TaskList)
        let taskListPresenter = TaskListPresenter(router: self)
        let taskListVC = taskListPresenter.getViewController()
        let homeNav = UINavigationController(rootViewController: taskListVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))

        // Create Settings Tab
        let settingsVC = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings",
                                              image: UIImage(systemName: "gear"),
                                              selectedImage: UIImage(systemName: "gear.fill"))

        // Setup TabBar
        tabBarController.setViewControllers([homeNav, settingsNav], animated: false)
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        start()
    }

    func goToDetail(of task: TodoTask) {
        navigationController.pushViewController(TaskDetailViewController(task: task), animated: true)
    }
}
