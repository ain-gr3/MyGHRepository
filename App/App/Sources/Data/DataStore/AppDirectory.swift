//
//  AppDirectory.swift
//  
//
//  Created by Ain Obara on 2022/03/05.
//

import Foundation

enum AppDirectory {

    case root
    case library(LibraryDirectory)
    case documents

    private var rootPath: String {
        NSHomeDirectory()
    }

    var path: String {
        switch self {
        case .root:
            return rootPath
        case .library(let libraryDirectory):
            return rootPath + "/Library" + libraryDirectory.path
        case .documents:
            return rootPath + "/Documents"
        }
    }
}

enum LibraryDirectory {

    case root
    case caches

    var path: String {
        switch self {
        case .root:
            return ""
        case .caches:
            return "/Caches"
        }
    }
}
