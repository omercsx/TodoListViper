//
//  LoginInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    
    let users = [
        User(username: "user1", password: "123123"),
        User(username: "user2", password: "123123"),
        User(username: "user3", password: "123123")
    ]
    
    weak var presenter: LoginInteractorOutputProtocol?
    
    func login(username: String, password: String) {
        print("Interactor: Login called")
        let loggedUser = User(username: username, password: password)
        
        let isValidUser = users.contains { user in
            user.username == loggedUser.username && user.password == loggedUser.password
        }
        
        if isValidUser {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            presenter?.loginSuccess()
        } else {
            presenter?.loginFailure(message: "Invalid username or password")
        }
    }
}
