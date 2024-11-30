//
//  LoginInteractorOutputProtocol.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import Foundation

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSuccess()
    func loginFailure(message: String)
}
