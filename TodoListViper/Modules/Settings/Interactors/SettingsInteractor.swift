//
//  SettingsInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import Foundation
import UIKit

protocol SettingsInteractorProtocol {
    var dataSource: DataSourceManaging { get }
    func toggleDarkMode(isOn: Bool)
    func logout()
}

class SettingsInteractor: SettingsInteractorProtocol {
    var dataSource: DataSourceManaging
    weak var presenter: SettingsPresenterProtocol?
    
    init() {
        self.dataSource = SettingsDataSource()
    }
    
    func toggleDarkMode(isOn: Bool) {
        (dataSource as? SettingsDataSource)?.updateDarkMode(isDarkMode: isOn)
        if isOn {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        UserDefaults.standard.set(isOn, forKey: "isDarkMode")
    }
    
    func logout() {
        // Clear user data
        UserDefaults.standard.removeObject(forKey: "userToken")
        presenter?.didLogout()
    }
}
