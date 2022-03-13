//
//  ListViewState.swift
//  
//
//  Created by Ain Obara on 2022/03/13.
//

import Foundation

enum ListViewState {

    case isLoading
    case hasError(ListViewError)
    case normal
}

enum ListViewError: Error {

    case noContents
    case cannotGetContents

    var description: String {
        switch self {
        case .noContents:
            return "コンテンツが 0 件です。"
        case .cannotGetContents:
            return "コンテンツを取得できませんでした。"
        }
    }
}
