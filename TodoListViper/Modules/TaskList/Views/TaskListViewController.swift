//
//  TaskListViewController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//
import UIKit

class TaskListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .systemBackground
        title = "Task List"
        presenter.fetchTaskList()
        setupCollectionView()
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
    }
    
    func showTaskList(_ taskList: [Task]) {
        print("ShowTaskList called with \(taskList.count) tasks")
        self.taskList = taskList
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func logoutButtonTapped() {
        presenter.logout()
    }
}

extension TaskListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UICollectionViewCell()
        }
        let task = taskList[indexPath.row]
        cell.configure(with: task)
        return cell
    }
}

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32 // Accounting for left and right insets
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.fetchTaskDetail(taskId: indexPath.row)
    }
}

extension TaskListViewController: TaskListPresenterDelegate {
    func didFetchTaskList(_ taskList: [Task]) {
        self.taskList = taskList
        collectionView.reloadData()
    }
}
