//
//  LoginInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

protocol LoginInteractorInputProtocol: AnyObject {
    func login(username: String, password: String, completion: (Bool, String?) -> Void)
}

class LoginInteractor: LoginInteractorInputProtocol {
    
    let users = [
        User(username: "user1", password: "123123"),
        User(username: "user2", password: "123123"),
        User(username: "user3", password: "123123")
    ]
    
    func login(username: String, password: String, completion: (Bool, String?) -> Void) {
        print("Interactor: Login called")
        let loggedUser = User(username: username, password: password)
        
        let isValidUser = users.contains { user in
            user.username == loggedUser.username && user.password == loggedUser.password
        }
        
        if isValidUser {
            completion(true, nil)
        } else {
            completion(false, "Invalid username or password")
        }
    }
}
