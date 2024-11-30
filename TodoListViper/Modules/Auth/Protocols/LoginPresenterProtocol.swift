//
//  LoginPresenterProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewController?  { get set }
    var router: LoginRouterProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    
    
    func login(username: String, password: String)
}
