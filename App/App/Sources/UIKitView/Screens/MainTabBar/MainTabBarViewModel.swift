//
//  File.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Foundation
import Domain
import RxSwift

public final class MainTabBarViewModel {

    let repositoryList: RepositoryList
    let output: RepositoryListOutputImplement

    public init(repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.output = output
        self.repositoryList = repositoryList
    }
}

public struct RepositoryListOutputImplement: RepositoryListOutput {

    let remotePublisher = PublishRelay<[RepositoryEntity]>()
    let localPublisher = PublishRelay<[RepositoryEntity]>()
    let updatedRepositoryPublisher = PublishRelay<RepositoryEntity>()
    let errorPublisher = PublishRelay<Error>()

    public init() {}

    public func recieveFromRemote(_ output: Result<[RepositoryEntity], Error>) {
        switch output {
        case .success(let entities):
            remotePublisher.accept(entities)
        case .failure(let error):
            errorPublisher.accept(error)
        }
    }

    public func recieveFromLocal(_ output: Result<[RepositoryEntity], Error>) {
        switch output {
        case .success(let entities):
            localPublisher.accept(entities)
        case .failure(let error):
            errorPublisher.accept(error)
        }
    }

    public func recieveUpdatedRepository(_ output: RepositoryEntity) {
        updatedRepositoryPublisher.accept(output)
    }
}
