//
//  LoginPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol, PresenterManaging {
    
    weak var view: LoginViewController?
    var interactor: LoginInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    init(router: MainRouterProtocol) {
        self.router = router
    }
    
    func login(username: String, password: String) {
        print("Presenter is logging in...")
        interactor?.login(username: username, password: password)
    }
    
    func loginSuccess() {
        print("Login Success presenter")
        router?.loginSuccess()
    }
    
    func loginFailure(message: String) {
        view?.showError(message: message)
    }
    
    // MARK: - Presenter Managing
    func getViewController() -> UIViewController {
        let viewController = LoginViewController()
        viewController.presenter = self 
        self.view = viewController
        return viewController
    }
}
