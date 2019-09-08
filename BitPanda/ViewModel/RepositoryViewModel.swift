//
//  RepositoryViewModel.swift
//  BitPanda
//
//  Created by Vinicius Leal on 06/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

protocol RepositoryViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class RepositoryViewModel {
    
    // MARK: - Properties
    
    weak var repositoriesDelegate: RepositoryViewModelDelegate?
    
    var repositories = [Item]()
    
    var currentPage = 1
    
    var isFetchInProgress = false
    
    let service = Service()
    
    // MARK: - Initializer
    
    init(delegate: RepositoryViewModelDelegate) {
        
        self.repositoriesDelegate = delegate
    }
    
    //    MARK: - API
    
    func fetchRepositories() {
        
        // Prevents multiple requests happening.
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true

        service.fetchRepositoriesList(page: currentPage) { (res) in
            switch res {
            case .success(let swiftRepositories):
                
                DispatchQueue.main.async {
                    
                    self.isFetchInProgress = false
                    
                    self.repositories.append(contentsOf: swiftRepositories.items)
                    
                    if self.currentPage > 1 {
                        
                        // Index paths to update collection.
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: swiftRepositories.items)
                        
                        // Inform delegate there's new data available to load.
                        self.repositoriesDelegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        // Inform delegate there's first amount of data to load
                        self.repositoriesDelegate?.onFetchCompleted(with: .none)
                    }
                    
                    self.currentPage += 1

                }
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    
                    // Inform delegate the motive of failure
                    self.repositoriesDelegate?.onFetchFailed(with: error.reason)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func repository(at index: Int) -> Item {
        return repositories[index]
    }
    
    // Calculates the index paths for the last page of repositories received from the API.
    func calculateIndexPathsToReload(from newRepositories: [Item]) -> [IndexPath] {
        
        let startIndex = repositories.count - newRepositories.count
        
        let endIndex = startIndex + newRepositories.count
        
        return (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
    }
    
}
