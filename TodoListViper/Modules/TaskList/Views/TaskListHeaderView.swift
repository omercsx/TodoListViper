//
//  TaskListHeaderView.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 5.12.2024.
//

import UIKit

class TaskListHeaderView: UICollectionReusableView {
    static let identifier = "TaskListHeaderView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Login-page"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
