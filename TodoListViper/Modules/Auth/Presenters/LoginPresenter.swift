//
//  LoginPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

protocol LoginPresenterDelegate: AnyObject {
    func loginFailure(message: String)
}

protocol LoginPresenterProtocol: AnyObject {
    var router: MainRouterProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var delegate: LoginPresenterDelegate? {get set}
    func login(username: String, password: String)
}


class LoginPresenter: LoginPresenterProtocol, PresenterManaging {
    
    var interactor: LoginInteractorInputProtocol?
    var router: MainRouterProtocol?
    weak var delegate: LoginPresenterDelegate?
    
    init(router: MainRouterProtocol) {
        self.router = router
        self.interactor = LoginInteractor()
    }
    
    func checkLogin() {
        
    }
    
    func login(username: String, password: String) {
        print("Presenter is logging in...")
        interactor?.login(username: username, password: password) {
            success, error in
            if let error {
                delegate?.loginFailure(message: error)
                return
            }
            
            router?.loginSuccess()
        }
    }
    
    // MARK: - Presenter Managing
    func getViewController() -> UIViewController {
        let viewController = LoginViewController(presenter: self)
        return viewController
    }
}
