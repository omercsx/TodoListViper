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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.identifier)
        return collectionView
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
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func configureWithDataSource(_ dataSource: DataSourceManaging?) {
        self.dataSource = dataSource
        (self.dataSource as? SettingsDataSource)?.delegate = self
        collectionView.reloadData()
    }
}

extension SettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell,
              let item = dataSource?.itemAt(index: indexPath.row) as? SettingsItem else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: item)
        cell.switchValueChanged = { [weak self] isOn in
            if item.type == .darkMode {
                self?.presenter?.didToggleDarkMode(isOn: isOn)
            }
        }
        
        return cell
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32 // Accounting for left and right insets
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.itemAt(index: indexPath.row) as? SettingsItem,
           item.type == .logout {
            presenter?.didTapLogout()
        }
    }
}

extension SettingsViewController: DataSourceManagingDelegate {
    func didLoadData() {
        collectionView.reloadData()
    }
}
