//
//  LoginRouter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    var presenter: LoginPresenterProtocol?
    
    static func createModule() -> LoginViewController {
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
        
        return view
    }
    
    func navigateToTaskList() {
        let taskListView = TaskListRouter.createModule()
        
        presenter?.view?.navigationController?.pushViewController(taskListView, animated: true)
    }
}
