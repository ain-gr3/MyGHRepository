//
//  RepositoryCellData.swift
//  
//
//  Created by Ain Obara on 2022/03/08.
//

import Foundation

struct RepositoryCellData {

    let title: String
    let subtitle: String
    let imageURL: URL
    let starCount: Int
    let isLastContent: Bool
}

extension RepositoryCellData {

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
