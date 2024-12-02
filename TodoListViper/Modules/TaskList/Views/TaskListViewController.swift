//
//  TaskListViewController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//
import UIKit

class TaskListViewController: UIViewController {
    
    let tableView = UITableView()
    
    var taskList: [Task] = []
    
    let presenter: TaskListPresenterProtocol
    
    init(presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.presenter.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TaskList ViewDidLoad called")
        tableView.dataSource = self
        tableView.delegate = self

        view.backgroundColor = .white

        title = "Task List"
        presenter.fetchTaskList()
        setupTableView()
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func showTaskList(_ taskList: [Task]) {
        print("ShowTaskList called with \(taskList.count) tasks")
        self.taskList = taskList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func logoutButtonTapped() {
        presenter.logout()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.fetchTaskDetail(taskId: indexPath.row)
    }
}

extension TaskListViewController: TaskListPresenterDelegate {
    func didFetchTaskList(_ taskList: [Task]) {
        self.taskList = taskList
        tableView.reloadData()
    }
}
