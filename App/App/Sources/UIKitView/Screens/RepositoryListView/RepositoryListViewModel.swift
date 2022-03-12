//
//  RepositoryListViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Foundation
import Domain
import RxSwift

enum ListViewType {
    case search
    case favorite
}

protocol RepositoryListViewModel {

    var repositories: Observable<[RepositoryCellData]> { get }
    func reloadRepositories()

}

final class SearchRepositoryListViewModel: RepositoryListViewModel {

    private let type: ListViewType = .search
    private let keyword: String
    private let repositoryList: RepositoryList
    private let output: RepositoryListOutputImplement

    var repositories: Observable<[RepositoryCellData]> {
        output.remotePublisher
            .map { entities -> [RepositoryCellData] in
                entities.map {
                    RepositoryCellData(entity: $0)
                }
            }
    }

    init(keyword: String, repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
        self.keyword = keyword
    }

    func reloadRepositories() {
        repositoryList.remoteRepositories(relatedTo: keyword)
    }
}

final class FavoriteRepositoryListViewModel: RepositoryListViewModel {

    private let repositoryList: RepositoryList
    private let output: RepositoryListOutputImplement

    var repositories: Observable<[RepositoryCellData]> {
        output.localPublisher
            .map { entities -> [RepositoryCellData] in
                entities.map {
                    RepositoryCellData(entity: $0)
                }
            }
    }

    init(repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
    }

    func reloadRepositories() {
        // TODO: handle error
        repositoryList.repository.fetchLocalRepository()
    }
}
