//
//  MainTabBarPresenter.swift
//  TodoListViper
//
//  Created by Mostafa Gamal on 2024-12-19.
//

import UIKit

protocol MainTabBarPresenterProtocol: AnyObject {
    func getViewController() -> UIViewController
}

class MainTabBarPresenterPresenter: MainTabBarPresenterProtocol {
    

    let router: MainRouterProtocol
    
    init(router: MainRouterProtocol) {
        self.router = router
    }
    
    func getViewController() -> UIViewController {
        let vc = MainTabBarController(router: router, presenter: self)
        return vc
    }
}
