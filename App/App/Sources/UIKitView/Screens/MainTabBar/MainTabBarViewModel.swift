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

    let remotePublisher = PublishSubject<[RepositoryEntity]>()
    let localPublisher = PublishSubject<[RepositoryEntity]>()

    public init() {}

    public func recieveFromRemote(_ output: Result<[RepositoryEntity], Error>) {
        switch output {
        case .success(let entities):
            remotePublisher.onNext(entities)
        case .failure(let error):
            remotePublisher.onError(error)
        }
    }

    public func recieveFromLocal(_ output: Result<[RepositoryEntity], Error>) {
        switch output {
        case .success(let entities):
            localPublisher.onNext(entities)
        case .failure(let error):
            localPublisher.onError(error)
        }
    }
}
