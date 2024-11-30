//
//  AppDelegate.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter

        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        let navigationController = isLoggedIn ?
            UINavigationController(rootViewController: TaskListRouter.createModule()) :
            UINavigationController(rootViewController: view)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

