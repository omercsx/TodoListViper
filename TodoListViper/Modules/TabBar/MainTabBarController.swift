//
//  MainTabBarController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    let router: MainRouterProtocol
    let presenter: MainTabBarPresenterProtocol
    
    init(router: MainRouterProtocol, presenter: MainTabBarPresenterProtocol) {
        self.router = router
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        configureTabs()
    }
    
    
    private func configureTabs() {
        // Create Home Tab (TaskList)
        let taskListPresenter = TaskListPresenter(router: router)
        let taskListVC = taskListPresenter.getViewController()
        let homeNav = UINavigationController(rootViewController: taskListVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))

        // Create Settings Tab
        let settingsVC = SettingsRouter.createModule(mainRouter: router)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings",
                                              image: UIImage(systemName: "gear"),
                                              selectedImage: UIImage(systemName: "gear.fill"))

        // Setup TabBar
        self.setViewControllers([homeNav, settingsNav], animated: false)
    }

    private func setupAppearance() {
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .systemBackground
    }
}
