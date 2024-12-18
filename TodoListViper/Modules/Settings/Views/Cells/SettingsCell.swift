import UIKit

class SettingsCell: UICollectionViewCell {
    static let identifier = "SettingsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var switchValueChanged: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 12
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchControl)
        contentView.addSubview(disclosureImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            disclosureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureImageView.widthAnchor.constraint(equalToConstant: 14),
            disclosureImageView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        switchControl.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        switchValueChanged?(sender.isOn)
    }
    
    func configure(with item: SettingsItem) {
        titleLabel.text = item.title
        
        switch item.type {
        case .darkMode:
            switchControl.isHidden = false
            disclosureImageView.isHidden = true
            switchControl.isOn = item.isDarkMode ?? false
        case .logout:
            switchControl.isHidden = true
            disclosureImageView.isHidden = false
        }
    }
}
