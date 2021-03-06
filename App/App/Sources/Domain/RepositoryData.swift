//
//  File.swift
//  
//
//  Created by Ain Obara on 2022/03/03.
//

import Foundation

public struct RepositoryData: Codable, Equatable {

    public let id: Int
    public let fullName: String
    public let htmlUrl: URL
    public let stargazersCount: Int
    public let language: String?
    public let owner: Owner
}

public struct Owner: Codable, Equatable {

    public let avatarUrl: URL
}
