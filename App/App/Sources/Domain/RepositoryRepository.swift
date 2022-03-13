//
//  RepositoryRepository.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

public protocol RepositoryRepository {

    func fetchLocalRepository() -> Result<[RepositoryData], Error>
    func fetchRemoteRepository(relatedTo keyword: String, completion: @escaping (Result<[RepositoryData], Error>) -> Void)
    func save(_ repository: RepositoryData) -> Result<Void, Error>
    func remove(_ repository: RepositoryData) -> Result<Void, Error>
}
