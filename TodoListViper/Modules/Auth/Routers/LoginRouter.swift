//
//  LoginRouter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    var presenter: LoginPresenterProtocol?
    
    func navigateToTaskList() {
        let taskListViewController = TaskListViewController()
        
        presenter?.view?.navigationController?.pushViewController(taskListViewController, animated: true)
    }
}
