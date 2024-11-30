//
//  LoginPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol {
    weak var view: LoginViewController?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func login(username: String, password: String) {
        interactor?.login(username: username, password: password)
    }
    
    func loginSuccess() {
        router?.navigateToTaskList()
    }
    
    func loginFailure(message: String) {
        view?.showError(message: message)
    }
}
