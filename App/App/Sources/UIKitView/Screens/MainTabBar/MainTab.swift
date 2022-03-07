//
//  MainTab.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import Foundation

enum MainTab: CaseIterable {

    case search
    case favorite
}

extension MainTab {

    var title: String {
        switch self {
        case .search:
            return "検索"
        case .favorite:
            return "お気に入り"
        }
    }

    var systemImageName: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .favorite:
            return "heart.fill"
        }
    }
}
