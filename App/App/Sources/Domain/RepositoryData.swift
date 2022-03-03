//
//  File.swift
//  
//
//  Created by Ain Obara on 2022/03/03.
//

import Foundation

public struct RepositoryData: Codable, Hashable {

    public let id: Int
    public let fullName: String
    public let url: URL
    public let stargazersCount: Int
    public let language: String
}
