import Foundation

enum SettingsItemType: String, Codable {
    case darkMode
    case logout
}

struct SettingsItem: Storable, Decodable {
    var id: String
    let title: String
    let type: SettingsItemType
    var isDarkMode: Bool?

    init(type: SettingsItemType, isDarkMode: Bool? = nil) {
        id = UUID().uuidString
        self.type = type
        self.isDarkMode = isDarkMode

        switch type {
        case .darkMode:
            title = "Dark Mode"
        case .logout:
            title = "Logout"
        }
    }
}
