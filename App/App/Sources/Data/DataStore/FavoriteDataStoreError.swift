//
//  FavoriteDataStoreError.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Foundation

enum FavoriteDataStoreError: Error {

    case alreadyLikedRepository
    case fileManagerError(FileManagerError)
    case cannotRemoveRepository
}
