//
//  MainTabBarController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }

    private func setupAppearance() {
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .systemBackground
    }
}
