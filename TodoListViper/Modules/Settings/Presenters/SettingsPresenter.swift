//
//  SettingsPresenter.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    
    func viewDidLoad()
    func didToggleDarkMode(isOn: Bool)
    func didTapLogout()
    func didLogout()
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouterProtocol?
    
    func viewDidLoad() {
        view?.configureWithDataSource(interactor?.dataSource)
    }
    
    func didToggleDarkMode(isOn: Bool) {
        interactor?.toggleDarkMode(isOn: isOn)
    }
    
    func didTapLogout() {
        interactor?.logout()
    }
    
    func didLogout() {
        router?.navigateToLogin()
    }
}
