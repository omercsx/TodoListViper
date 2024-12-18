//
//  SettingsRouter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import UIKit

protocol SettingsRouterProtocol {
    func navigateToLogin()
}

class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: UIViewController?
    private var mainRouter: MainRouterProtocol?
    
    init(mainRouter: MainRouterProtocol? = nil) {
        self.mainRouter = mainRouter
    }
    
    static func createModule(mainRouter: MainRouterProtocol? = nil) -> UIViewController {
        let router = SettingsRouter(mainRouter: mainRouter)
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        let view = SettingsViewController(presenter: presenter)
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToLogin() {
        mainRouter?.logout()
    }
}
