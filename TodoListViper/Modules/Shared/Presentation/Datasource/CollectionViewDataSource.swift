//
//  CollectionViewDataSource.swift
//  TodoListViper
//
//  Created by Mostafa Gamal on 2024-12-06.
//

protocol DataSourceManaging {
    var delegate: DataSourceManagingDelegate? {get set}
    var items: [any Storable]? {get}
    func setItems(items: [any Storable])
    func addItem(item: any Storable)
    func itemAt(index: Int) -> (any Storable)?
    var numItems: Int {get}
}


protocol DataSourceManagingDelegate: AnyObject {
    func didLoadData()
}

class TaskListDataSource: DataSourceManaging {

    weak var delegate: DataSourceManagingDelegate?
    
    var items: [any Storable]?
    
    func setItems(items: [any Storable]) {
        self.items = items
        delegate?.didLoadData()
    }
    
    func itemAt(index: Int) -> (any Storable)? {
        items?.indices.contains(index) == true ? items?[index] : nil
    }
    
    func addItem(item: any Storable) {
        items?.append(item)
        delegate?.didLoadData()
    }
    
    var numItems: Int {
        return items?.count ?? 0
    }
}
