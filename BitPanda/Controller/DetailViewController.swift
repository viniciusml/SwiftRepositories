//
//  DetailViewController.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: DetailViewModel?
    
    let detailView = DetailView()
    
    // MARK: - Initializers
    
    init(repoFullName: String) {
        super.init(nibName: nil, bundle: nil)
        
        viewModel = DetailViewModel(delegate: self)
        viewModel?.fetchRepositoryDetail(fullName: repoFullName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(detailView)
        detailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
    }
}

// MARK: - Detail View Model Delegate

extension DetailViewController: DetailViewModelDelegate {
    
    func onFetchContributorsCompleted(contributors: [Contributor]) {
        
        detailView.contributors = contributors
    }
    
    func onFetchCompleted(repositoryDetail: RepositoryDetail) {
        
        detailView.repositoryDetail = repositoryDetail
    }
    
    func onFetchFailed(with reason: String) {
        
        Alert().showBasicAlert(title: "Failed", message: reason, vc: self)
    }
    
}
