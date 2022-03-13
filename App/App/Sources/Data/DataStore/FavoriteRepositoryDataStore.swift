//
//  File.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Domain

final class FavoriteRepositoryDataStore {

    private let fileManager = AppFileManager(dataConverter: RepositoryDataConverter())
    private let fileName = "favorite_repositories_list.json"
    private var repositories: [RepositoryData] = []

    func fetchRepositories() -> Result<[RepositoryData],FavoriteDataStoreError> {
        switch fileManager.getContents(at: .documents, fileName: fileName) {
        case .success(let repositories):
            self.repositories = repositories
            return .success(repositories)
        case .failure(let error) where error == .noSuchFile:
            let result = fileManager.save(fileName, at: .documents, object: [])
            switch result {
            case .success(()):
                return .success([])
            case .failure(let error):
                return .failure(.fileManagerError(error))
            }
        case .failure(let error):
            return .failure(.fileManagerError(error))
        }
    }

    func add(_ repository: RepositoryData) -> Result<Void, FavoriteDataStoreError> {
        guard !repositories.contains(where: { $0.id == repository.id }) else {
            return .failure(.alreadyLikedRepository)
        }
        repositories.append(repository)
        switch fileManager.save(fileName, at: .documents, object: repositories) {
        case .success(()):
            return .success(())
        case .failure(let error):
            return .failure(.fileManagerError(error))
        }
    }

    func remove(_ repository: RepositoryData) -> Result<Void, FavoriteDataStoreError> {
        guard let index = repositories.firstIndex(where: { $0.id == repository.id }) else {
            return .failure(.cannotRemoveRepository)
        }
        repositories.remove(at: index)
        switch fileManager.save(fileName, at: .documents, object: repositories) {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(.fileManagerError(error))
        }
    }
}
