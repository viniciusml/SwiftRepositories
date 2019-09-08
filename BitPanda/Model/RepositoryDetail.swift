//
//  RepositoryDetail.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

// MARK: - RepositoryDetail
struct RepositoryDetail: Codable {
    let name, fullName: String?
    let repositoryDetailDescription: String?
    let size, stargazersCount: Int?
    let forksCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case repositoryDetailDescription = "description"
        case size
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}
