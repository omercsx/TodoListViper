//
//  Storable.swift
//  TodoListViper
//
//  Created by Mostafa Gamal on 2024-12-06.
//

protocol Storable: Hashable, Codable {
    var id: String {get set}
}


extension Storable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
