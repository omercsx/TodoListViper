//
//  LoginInteractorInputProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import Foundation

protocol LoginInteractorInputProtocol: AnyObject {
    func login(username: String, password: String)
}