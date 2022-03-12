//
//  File.swift
//  
//
//  Created by Ain Obara on 2022/03/03.
//

import Foundation

public class RepositoryEntity: Identifiable {

    public let id: Int
    public let name: String
    public let language: String
    public let starCount: Int
    public let url: URL
    public let avatarURL: URL

    public var isLiked: Bool {
        didSet {
            // TODO: publish event
        }
    }

    public init(data: RepositoryData, isLiked: Bool) {
        self.id = data.id
        self.name = data.fullName
        self.language = data.language ?? "no setting"
        self.starCount = data.stargazersCount
        self.url = data.url
        self.isLiked = isLiked
        self.avatarURL = data.owner.avatarUrl
    }

    internal var data: RepositoryData {
        RepositoryData(
            id: id,
            fullName: name,
            url: url,
            stargazersCount: starCount,
            language: language,
            owner: .init(avatarUrl: avatarURL)
        )
    }
}

extension RepositoryEntity: Equatable {

    public static func == (lhs: RepositoryEntity, rhs: RepositoryEntity) -> Bool {
        lhs.id == rhs.id
    }
}
