//
//  DetailViewModel.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func onFetchCompleted(repositoryDetail: RepositoryDetail)
    func onFetchContributorsCompleted(contributors: [Contributor])
    func onFetchFailed(with reason: String)
}

class DetailViewModel {
    
    // MARK: - Properties
    
    let service = Service()
    
    weak var detailsDelegate: DetailViewModelDelegate?
    
    var contributors = [Contributor]()
    
    // MARK: - Initializer
    
    init(delegate: DetailViewModelDelegate) {
        
        self.detailsDelegate = delegate
    }
    
    // MARK: - API
    
    func fetchRepositoryDetail(fullName: String) {
        
        service.fetchRepositoryDetail(fullName: fullName) { (res) in
            switch res {
            case .success(let repositoryDetail):
                
                DispatchQueue.main.async {
                    // Inform delegate data about repository detail
                    self.detailsDelegate?.onFetchCompleted(repositoryDetail: repositoryDetail)
                }
                
            case .failure(let err):
                print("Failure to fetch details:", err)
                
                DispatchQueue.main.async {
                    // Inform delegate the motive of failure
                    self.detailsDelegate?.onFetchFailed(with: err.reason)
                }
                
            }
        }
        
        service.fetchContributorsList(fullName: fullName) { (res) in
            switch res {
            case .success(let contributors):
                
                DispatchQueue.main.async {
                    // Inform delegate data with contributors array
                    self.detailsDelegate?.onFetchContributorsCompleted(contributors: contributors)
                }
                
            case .failure(let err):
                print("Failure to fetch details:", err)
                
                DispatchQueue.main.async {
                    // Inform delegate the motive of failure
                    self.detailsDelegate?.onFetchFailed(with: err.reason)
                }
                
            }
        }
    }
}
