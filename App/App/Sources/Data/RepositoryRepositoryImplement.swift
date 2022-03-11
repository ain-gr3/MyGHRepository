//
//  RepositoryRepositoryImplement.swift
//  
//
//  Created by Ain Obara on 2022/03/11.
//

import Domain

struct RepositoryRepositoryImplement: RepositoryRepository {

    let apiClient = AppAPIClient()
    let dataStore = FavoriteRepositoryDataStore()

    func fetchRemoteRepository(relatedTo keyword: String, completion: @escaping (Result<[RepositoryData], Error>) -> Void) {
        apiClient.send(.searchRepositoriesRequest(searchWord: keyword)) { reslut in
            switch reslut {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchLocalRepository() -> Result<[RepositoryData], Error> {
        switch dataStore.fetchRepositories() {
        case .success(let repositories):
            return .success(repositories)
        case .failure(let error):
            return .failure(error)
        }
    }

    func save(_ repository: RepositoryData) -> Result<Void, Error> {
        switch dataStore.add(repository) {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }

    func remove(_ repository: RepositoryData) -> Result<Void, Error> {
        switch dataStore.remove(repository) {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
