//
//  LocalRepositoryRepository.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

public protocol LocalRepositoryRepository {

    func fetchRemoteRepository(relatedTo keyword: String) -> Result<[RepositoryData], Error>
    func fetchLocalRepository() -> Result<[RepositoryData], Error>
    func save(_ repository: RepositoryData) -> Result<Void, Error>
    func remove(_ repository: RepositoryData) -> Result<Void, Error>
}
