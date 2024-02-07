//
//  ListTableViewCell.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 03.02.2024.
//

import UIKit
import Kingfisher

// MARK: - ListTableViewCellDelegate
protocol ListTableViewCellDelegate: AnyObject {
    func longPressed(cell: UITableViewCell)
}

// MARK: - ListTableViewCell
class ListTableViewCell: UITableViewCell {
    
    // MARK: - Public propertie
    weak var delegate: ListTableViewCellDelegate?
    
    // MARK: - Private properties
    private(set) lazy var fileImage: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    private(set) lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    // MARK: - Lifecycle
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupViews()
            setupConstraints()
            backgroundColor = .clear
            selectionStyle = .none
            setupLongPressGesture()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - Public methods
    func configureWith(image: String, text: String) {
        fileImage.kf.setImage(with: URL(string: image))
        nameLabel.text = text
    }
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            delegate?.longPressed(cell: self)
        }
    }
    
    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(fileImage)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            fileImage.widthAnchor.constraint(equalToConstant: 100),
            fileImage.heightAnchor.constraint(equalToConstant: 100),
            fileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: fileImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
