//
//  TaskListViewController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//
import UIKit
import Combine

class TaskListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            return indicator
        }()
    
    //Always use access modifiers public/private
    private var dataSource: DataSourceManaging?
    private let presenter: TaskListPresenterProtocol
    private var isBusy = true
    private var cancellables: Set<AnyCancellable> = []
    
    init(presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        self.presenter.delegate = self
        bindToPresenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .systemBackground
        
        presenter.fetchTaskList()
        setupCollectionView()
        setupNavigationItems()
    }
    
    func bindToPresenter() {
        presenter.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }
    
    public func setDataSource(dataSource: DataSourceManaging) {
        self.dataSource = dataSource
        self.dataSource?.delegate = self
    }
    private func setupNavigationItems() {
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesBackButton = true
        navigationItem.title = "Task List"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add Task", style: .plain, target: self, action: #selector(addTaskButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    @objc private func addTaskButtonTapped() {
        // presenter.addTask()
        let alert = UIAlertController(
            title: "Add Task", message: "Enter task details", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Task Title"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Task Description"
        }
        
        alert.addAction(
            UIAlertAction(
                title: "Add", style: .default,
                handler: { _ in
                    if let title = alert.textFields?.first?.text,
                       let desc = alert.textFields?.last?.text {
                        let newTask = TodoTask(id: "someID", title: title, description: desc, isCompleted: false, completionDate: nil)
                        self.presenter.addTask(newTask)
                    }
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
        collectionView.register(
            TaskListHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TaskListHeaderView.identifier
        )
        
        // Activity Indicator Layout Constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
        ])
    }
    
    @objc private func logoutButtonTapped() {
        presenter.logout()
    }
}

extension TaskListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int {
        return dataSource?.numItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        let defaultCell = UICollectionViewCell()
        guard
            let dataSource,
                let itemModel = dataSource.itemAt(index: indexPath.row),
                let taskModel = itemModel as? TodoTask else {
            print("Error: cannot get item at index\(indexPath.row)")
            return defaultCell
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
        else {
            //Raise error here
            return defaultCell
        }

        cell.configure(with: taskModel)
        return cell
    }
}

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - 32 // Accounting for left and right insets
        // Dynamic sizing
        guard let item = dataSource?.itemAt(index: indexPath.row) as? TodoTask else {
            //Raise error
            return CGSize.zero
        }
        
        return item.isCompleted ? CGSize(width: width, height: 80) : CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //Notes: We dont use force unwrap "!", because if it fails, the app will crash
        //Always use guard statments to block execution at function start
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TaskListHeaderView.identifier, for: indexPath) as? TaskListHeaderView else {
            return UICollectionReusableView()
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.fetchTaskDetail(taskId: indexPath.row)
    }
}

extension TaskListViewController: TaskListPresenterDelegate {
    //Add any as needed
}


extension TaskListViewController: DataSourceManagingDelegate {
    func didLoadData() {
        collectionView.reloadData()
    }
}
