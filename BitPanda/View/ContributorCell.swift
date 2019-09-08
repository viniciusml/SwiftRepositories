//
//  ContributorCell.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class ContributorCell: BaseCell {
    
    // MARK: - Properties
    
    var contributor: Contributor! {
        didSet {
            guard let contributorUrl = contributor.author?.avatarURL else { return }
            guard let weeks = contributor.weeks else { return }
            
            contributorProfile.loadImage(urlString: contributorUrl)
            loginName.text = contributor.author?.login
            aditionsLabel.text = "Aditions: \(weeks.reduce(0) { $0 + $1.a!})"
            deletionsLabel.text = "Deletions: \(weeks.reduce(0) { $0 + $1.d!})"
            commitsLabel.text = "Commits: \(weeks.reduce(0) { $0 + $1.c!})"
            
            aditionsPWLabel.text = "\(weeks.reduce(0) { $0 + $1.a!} / weeks.count)/week"
            deletionsPWLabel.text = "\(weeks.reduce(0) { $0 + $1.d!} / weeks.count)/week"
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let contributorProfile: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = .gainsboroGray
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let loginName = UILabel(font: UIFont(name: Font.medium, size: 17)!)
    
    let aditionsLabel = UILabel(font: UIFont(name: Font.regular, size: 14)!)
    
    let aditionsPWLabel = UILabel(font: UIFont(name: Font.semibold, size: 13)!)
    
    let deletionsLabel = UILabel(font: UIFont(name: Font.regular, size: 14)!)
    
    let deletionsPWLabel = UILabel(font: UIFont(name: Font.semibold, size: 13)!)
    
    let commitsLabel = UILabel(font: UIFont(name: Font.regular, size: 14)!)
    
    // MARK: - Helper Functions
    
    override func setupViews() {
        
        clipsToBounds = true
        layer.cornerRadius = 12
        backgroundColor = UIColor.orange.withAlphaComponent(0.2)
        
        addSubview(contributorProfile)
        contributorProfile.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), size: CGSize(width: 90, height: 90))
        
        let aditionsStack = HorizontalStackView(arrangedSubviews: [aditionsLabel, aditionsPWLabel], spacing: 0, alignment: .fill)
        
        aditionsPWLabel.constrainWidth(constant: 80)
        aditionsPWLabel.textAlignment = .right
        
        deletionsPWLabel.constrainWidth(constant: 80)
        deletionsPWLabel.textAlignment = .right
        
        let deletionsStack = HorizontalStackView(arrangedSubviews: [deletionsLabel, deletionsPWLabel], spacing: 0, alignment: .fill)
        
        let labels = [loginName, aditionsStack, deletionsStack, commitsLabel]
        
        let labelsVStack = VerticalStackView(arrangedSubviews: labels)
        
        addSubview(labelsVStack)
        labelsVStack.anchor(top: contributorProfile.topAnchor, leading: contributorProfile.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
}
