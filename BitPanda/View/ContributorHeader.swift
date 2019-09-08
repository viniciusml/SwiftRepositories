//
//  ContributorHeader.swift
//  BitPanda
//
//  Created by Vinicius Leal on 08/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class ContributorHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let headerTitle = UILabel(font: UIFont(name: Font.semibold, size: 20)!, color: .white, alignment: .center)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupViews() {
        
        backgroundColor = .black
        clipsToBounds = true
        layer.cornerRadius = 12
        
        headerTitle.text = "Contributors"
        addSubview(headerTitle)
        headerTitle.fillSuperview()
    }
}
