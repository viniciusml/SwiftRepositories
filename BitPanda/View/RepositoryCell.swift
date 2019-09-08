//
//  RepositoryCell.swift
//  BitPanda
//
//  Created by Vinicius Leal on 06/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class RepositoryCell: BaseCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let nameLabel = UILabel(font: UIFont(name: Font.medium, size: 18)!, numberOfLines: 0)
    
    let fullNameLabel = UILabel(font: UIFont(name: Font.medium, size: 16)!, color: .gray)
    
    let languageLabel = UILabel(font: UIFont(name: Font.medium, size: 12)!, color: .white)
    
    // MARK: - Helper functions
    
    override func setupViews() {
        
        layer.cornerRadius = 12
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        
        [nameLabel, fullNameLabel, languageLabel].forEach({
            $0.backgroundColor = .white
            addSubview($0)
        })
        
        nameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 80), size: CGSize(width: 0, height: 30))
        
        languageLabel.backgroundColor = .orange
        languageLabel.layer.cornerRadius = 8
        languageLabel.clipsToBounds = true
        languageLabel.textAlignment = .center
        languageLabel.anchor(top: self.topAnchor, leading: nameLabel.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 20), size: CGSize(width: 60, height: 20))
        
        fullNameLabel.anchor(top: nameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 35))
        fullNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    // Configures UI in cell.
    func configure(with repository: Item?) {
        
        if let item = repository {
            nameLabel.text = item.name
            fullNameLabel.text = item.fullName
            languageLabel.text = item.language
        }
    }
    
}
