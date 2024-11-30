//
//  PresenterManaging.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import UIKit

protocol PresenterManaging: AnyObject {
    func getViewController() -> UIViewController
}
