//
//  RepositoryList.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

public protocol RepositoryListOutput {
    func recieve(_ output: Result<[RepositoryEntity], Error>)
}

public struct RepositoryList {

    private let repository: RepositoryRepository
    private let mediator: RepositoryListOutput

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

                    mediator.recieve(.success(repositoryEntities))
                case .failure(let error):
                    mediator.recieve(.failure(error))
                    break
                }
            case .failure(let error):
                mediator.recieve(.failure(error))
                break
            }
        }
    }

    public func localRepositories() {
        switch repository.fetchLocalRepository() {
        case .success(let repositoriesData):
            let repositoryEntities = repositoriesData.map { RepositoryEntity(data: $0, isLiked: true)}
            mediator.recieve(.success(repositoryEntities))
        case .failure(let error):
            mediator.recieve(.failure(error))
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
