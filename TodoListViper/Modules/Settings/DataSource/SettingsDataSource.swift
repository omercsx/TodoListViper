import Foundation

class SettingsDataSource: DataSourceManaging {
    weak var delegate: DataSourceManagingDelegate?
    var items: [any Storable]?
    
    init() {
        self.items = [
            SettingsItem(type: .darkMode, isDarkMode: false),
            SettingsItem(type: .logout)
        ]
    }
    
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
    
    func updateDarkMode(isDarkMode: Bool) {
        if let index = items?.firstIndex(where: { ($0 as? SettingsItem)?.type == .darkMode }) {
            var darkModeItem = items?[index] as? SettingsItem
            darkModeItem?.isDarkMode = isDarkMode
            items?[index] = darkModeItem ?? items![index]
            delegate?.didLoadData()
        }
    }
    
    var numItems: Int {
        return items?.count ?? 0
    }
}
