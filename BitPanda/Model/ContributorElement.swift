//
//  ContributorElement.swift
//  BitPanda
//
//  Created by Vinicius Leal on 07/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

// MARK: - ContributorElement
struct Contributor: Codable {
    let total: Int?
    let weeks: [Week]?
    let author: Author?
}

// MARK: - Author
struct Author: Codable {
    let login: String?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

// MARK: - Week
struct Week: Codable {
    let w, a, d, c: Int?
}

typealias Contributors = [Contributor]
