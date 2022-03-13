//
//  RepositoryList.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

public protocol RepositoryListOutput {
    func recieveFromRemote(_ output: Result<[RepositoryEntity], Error>)
    func recieveFromLocal(_ output: Result<[RepositoryEntity], Error>)
}

public struct RepositoryList {

    public let repository: RepositoryRepository
    public let output: RepositoryListOutput

    public func remoteRepositories(relatedTo keyword: String) {
        repository.fetchRemoteRepository(relatedTo: keyword) { result in
            switch result {
            case .success(let remoteRepositoriesData):
                switch repository.fetchLocalRepository() {
                case .success(let localRepositoriesData):
                    let repositoryEntities = remoteRepositoriesData.map { remoteRepositoryData -> RepositoryEntity in
                        if localRepositoriesData.contains(remoteRepositoryData) {
                            return RepositoryEntity(data: remoteRepositoryData, isLiked: true)
                        } else {
                            return RepositoryEntity(data: remoteRepositoryData, isLiked: false)
                        }
                    }

                    output.recieveFromRemote(.success(repositoryEntities))
                case .failure(let error):
                    output.recieveFromRemote(.failure(error))
                    break
                }
            case .failure(let error):
                output.recieveFromRemote(.failure(error))
                break
            }
        }
    }

    public func localRepositories() {
        switch repository.fetchLocalRepository() {
        case .success(let repositoriesData):
            let repositoryEntities = repositoriesData.map { RepositoryEntity(data: $0, isLiked: true)}
            output.recieveFromLocal(.success(repositoryEntities))
        case .failure(let error):
            output.recieveFromLocal(.failure(error))
            break
        }
    }

    public func toggleIsLiked(of repositoryEntity: RepositoryEntity) {
        let pastIsLiked = repositoryEntity.isLiked
        repositoryEntity.isLiked = !pastIsLiked

        let data = repositoryEntity.data
        let result = pastIsLiked ? repository.remove(data) : repository.save(data)
        switch result {
        case .success:
            break
        case .failure:
            repositoryEntity.isLiked = pastIsLiked
        }
    }
}

extension RepositoryList {

    public init(_repository: RepositoryRepository, _output: RepositoryListOutput) {
        self.init(repository: _repository, output: _output)
    }
}
