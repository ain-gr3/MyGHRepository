//
//  RepositoryRepositoryImplement.swift
//  
//
//  Created by Ain Obara on 2022/03/11.
//

import Domain

public struct RepositoryRepositoryImplement: RepositoryRepository {

    let apiClient = AppAPIClient()
    let dataStore = FavoriteRepositoryDataStore()

    public init() {}

    public func fetchRemoteRepository(relatedTo keyword: String, completion: @escaping (Result<[RepositoryData], Error>) -> Void) {
        apiClient.send(.searchRepositoriesRequest(searchWord: keyword)) { reslut in
            switch reslut {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func fetchLocalRepository() -> Result<[RepositoryData], Error> {
        switch dataStore.fetchRepositories() {
        case .success(let repositories):
            return .success(repositories)
        case .failure(let error):
            return .failure(error)
        }
    }

    public func save(_ repository: RepositoryData) -> Result<Void, Error> {
        switch dataStore.add(repository) {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }

    public func remove(_ repository: RepositoryData) -> Result<Void, Error> {
        switch dataStore.remove(repository) {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
