//
//  ListViewType.swift
//  
//
//  Created by Ain Obara on 2022/03/13.
//

import Foundation

enum ListViewType {
    case search(keyword: String)
    case favorite

    var title: String {
        switch self {
        case .search(let keyword):
            return keyword.isEmpty ? "" : "'\(keyword)'"
        case .favorite:
            return "お気に入り"
        }
    }
}
