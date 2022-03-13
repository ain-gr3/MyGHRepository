//
//  RepositoryCellData.swift
//  
//
//  Created by Ain Obara on 2022/03/08.
//

import Foundation
import Domain

struct RepositoryCellData {

    let title: String
    let subtitle: String
    let imageURL: URL
    let starCount: Int
    let isLastContent: Bool
}

extension RepositoryCellData {

    init(entity: RepositoryEntity) {
        self.init(
            title: entity.name,
            subtitle: entity.language,
            imageURL: entity.avatarURL,
            starCount: entity.starCount,
            isLastContent: entity.isLiked
        )
    }

    static var sample: Self {
        self.init(
            title: "apple/Swift",
            subtitle: "Swift",
            imageURL: URL(string: "https://avatars.githubusercontent.com/u/10639145?v=4")!,
            starCount: 100000,
            isLastContent: false
        )
    }
}
