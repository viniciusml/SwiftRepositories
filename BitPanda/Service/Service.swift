//
//  Service.swift
//  BitPanda
//
//  Created by Vinicius Leal on 06/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

/// Fetch data from API.
class Service {
        
    /// Fetch all project repositories written using the Swift language, displayed 25 results per page.
    func fetchRepositoriesList(page: Int, completion: @escaping (Result<Repository, ResponseError>) -> ()) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&page=\(page)&per_page=25") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            // Handle network error
            if err != nil {
                completion(.failure(ResponseError.network))
                return
            }
            
            do {
                let swiftRepositories = try JSONDecoder().decode(Repository.self, from: data!)
                completion(.success(swiftRepositories))
            } catch {
                // Handle decoding error
                completion(.failure(ResponseError.decoding))
            }
            
            }.resume()
    }
    
    /// Fetch details of specific repository.
    func fetchRepositoryDetail(fullName: String, completion: @escaping (Result<RepositoryDetail, ResponseError>) -> ()) {

        guard let url = URL(string: "https://api.github.com/repos/\(fullName)") else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in

            // HHandle network error
            if err != nil {
                completion(.failure(ResponseError.network))
                return
            }

            do {
                let repositoryDetail = try JSONDecoder().decode(RepositoryDetail.self, from: data!)
                completion(.success(repositoryDetail))
            } catch {
                // Handle decoding error
                completion(.failure(ResponseError.decoding))
            }

            }.resume()
    }
    
    /// Fetch contributors list of specific repository.
    func fetchContributorsList(fullName: String, completion: @escaping (Result<[Contributor], ResponseError>) -> ()) {
        
        guard let url = URL(string: "https://api.github.com/repos/\(fullName)/stats/contributors") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            // Handle network error
            if err != nil {
                completion(.failure(ResponseError.network))
                return
            }
            
            do {
                let contributors = try JSONDecoder().decode([Contributor].self, from: data!)
                completion(.success(contributors))
            } catch {
                // Handle decoding error
                completion(.failure(ResponseError.decoding))
            }
            
            }.resume()
    }
}
