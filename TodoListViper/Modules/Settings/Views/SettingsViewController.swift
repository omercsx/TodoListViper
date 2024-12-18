//
//  SettingsViewController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 9.12.2024.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func configureWithDataSource(_ dataSource: DataSourceManaging?)
}

class SettingsViewController: UIViewController {
    private var presenter: SettingsPresenterProtocol?
    private var dataSource: DataSourceManaging?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        return tableView
    }()
    
    init(presenter: SettingsPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func configureWithDataSource(_ dataSource: DataSourceManaging?) {
        self.dataSource = dataSource
        (self.dataSource as? SettingsDataSource)?.delegate = self
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        if let item = dataSource?.itemAt(index: indexPath.row) as? SettingsItem {
            cell.textLabel?.text = item.title
            
            switch item.type {
            case .darkMode:
                let switchView = UISwitch()
                switchView.isOn = item.isDarkMode ?? false
                switchView.addTarget(self, action: #selector(darkModeSwitchChanged(_:)), for: .valueChanged)
                cell.accessoryView = switchView
                cell.selectionStyle = .none
            case .logout:
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = dataSource?.itemAt(index: indexPath.row) as? SettingsItem,
           item.type == .logout {
            presenter?.didTapLogout()
        }
    }
    
    @objc private func darkModeSwitchChanged(_ sender: UISwitch) {
        presenter?.didToggleDarkMode(isOn: sender.isOn)
    }
}

extension SettingsViewController: DataSourceManagingDelegate {
    func didLoadData() {
        tableView.reloadData()
    }
}
