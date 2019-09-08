//
//  SwiftRepositories.swift
//  BitPanda
//
//  Created by Vinicius Leal on 06/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

// MARK: - SwiftRepositories
struct Repository: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let name, fullName: String
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case language
    }
}
