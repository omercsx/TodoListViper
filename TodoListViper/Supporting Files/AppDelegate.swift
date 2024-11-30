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
    var router: MainRouterProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window else { return false }
        
        let mainRouter = MainRouter(appRoot: window)
        router = mainRouter
        router?.start()
        
        return true
    }
}

