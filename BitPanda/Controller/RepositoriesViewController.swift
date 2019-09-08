//
//  ViewController.swift
//  BitPanda
//
//  Created by Vinicius Leal on 06/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class RepositoriesViewController: UICollectionViewController {

    // MARK: - Properties
    
    var repositoryViewModel: RepositoryViewModel!
    
    // MARK: - Initializers
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SWIFT REPOSITORIES"
        collectionView.prefetchDataSource = self
        repositoryViewModel = RepositoryViewModel(delegate: self)
        repositoryViewModel.fetchRepositories()
        
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: RepositoryCell.identifier)
        collectionView.backgroundColor = .white

        collectionView.isPrefetchingEnabled = true
    }
    
    // MARK: - Helper Funtions
    
    // Checks if the cell at at -8 items from the last one received is being displayed.
    func isDisplayingCell(for indexPath: IndexPath) -> Bool {
        
        return indexPath.item >= repositoryViewModel.repositories.count - 8
    }
    
}

// MARK: - Collection View Delegate

extension RepositoriesViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return repositoryViewModel.repositories.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 40), height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 8, right: 10)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        
        cell.configure(with: repositoryViewModel.repository(at: indexPath.item))

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? RepositoryCell else { return }
        guard let repositoryFullName = cell.fullNameLabel.text else { return }
        guard let repositoryName = cell.nameLabel.text else { return }

        let detailController = DetailViewController(repoFullName: repositoryFullName)
        detailController.title = repositoryName.uppercased()

        navigationController?.pushViewController(detailController, animated: true)
    }

}

// MARK: - Collection View Prefetching

extension RepositoriesViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        // Prefetchs data
        if indexPaths.contains(where: isDisplayingCell) {
            repositoryViewModel.fetchRepositories()
        }
    }
}

// MARK: - Repository View Model Delegate

extension RepositoriesViewController: RepositoryViewModelDelegate {
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        
        // When first page is received, content is reloaded.
        // When next pages are received, insert and reload new items.
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            collectionView.reloadData()
            return
        }
        
        collectionView.insertItems(at: newIndexPathsToReload)
        collectionView.reloadItems(at: newIndexPathsToReload)
        
    }
    
    func onFetchFailed(with reason: String) {
        
        Alert().showBasicAlert(title: "Failed", message: reason, vc: self)
    }

}
