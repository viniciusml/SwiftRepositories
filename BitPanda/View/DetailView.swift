//
//  DetailView.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class DetailView: UIView {

    // MARK: - Properties
    
    var repositoryDetail: RepositoryDetail? {
        
        didSet {
            guard let detail = repositoryDetail else { return }
            
            descriptionLabel.text = detail.repositoryDetailDescription
            sizeLabel.text = "Size: " + "\(detail.size ?? 0)"
            stargazersLabel.text = "Stargazers: " + "\(detail.stargazersCount ?? 0)"
            forksCountLabel.text = "Forks: " + "\(detail.forksCount ?? 0)"
        }
    }
    
    var contributors: [Contributor]? {
        didSet {
            contributorsCV.reloadData()
        }
    }
    
    let layout = UICollectionViewFlowLayout()
    
    var contributorsCV: UICollectionView!
    
    let descriptionLabel = UILabel(font: UIFont(name: Font.medium, size: 22)!, numberOfLines: 0, alignment: .center)
    
    let sizeLabel = UILabel(font: UIFont(name: Font.medium, size: 16)!, alignment: .center)
    
    let stargazersLabel = UILabel(font: UIFont(name: Font.medium, size: 16)!, alignment: .center)
    
    let forksCountLabel = UILabel(font: UIFont(name: Font.medium, size: 16)!, alignment: .center)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupCollectionView() {
        
        contributorsCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contributorsCV.delegate = self
        contributorsCV.dataSource = self
        contributorsCV.register(ContributorCell.self, forCellWithReuseIdentifier: ContributorCell.identifier)
        contributorsCV.register(ContributorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContributorHeader.identifier)
    }
    
    func setupUI() {
        
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = UIColor.orange.withAlphaComponent(0.6).cgColor
        layer.borderWidth = 5
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 140))
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        let infoLabels = [sizeLabel, stargazersLabel, forksCountLabel]
        
        let labelVStack = VerticalStackView(arrangedSubviews: infoLabels, spacing: 10)
        addSubview(labelVStack)
        labelVStack.anchor(top: descriptionLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20))
        
        addSubview(contributorsCV)
        contributorsCV.backgroundColor = .white
        contributorsCV.anchor(top: labelVStack.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        
    }
}

// MARK: - Collection View

extension DetailView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contributors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = contributorsCV.dequeueReusableCell(withReuseIdentifier: ContributorCell.identifier, for: indexPath) as! ContributorCell
        
        let contributor = contributors?[indexPath.item]
        cell.contributor = contributor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: (self.frame.width - 60), height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = contributorsCV.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContributorHeader.identifier, for: indexPath) as! ContributorHeader
        
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width - 60), height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 8, right: 10)
    }
}
