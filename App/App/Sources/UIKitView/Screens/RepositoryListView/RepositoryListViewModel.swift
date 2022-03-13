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
    case search(keyword: String)
    case favorite

    var title: String {
        switch self {
        case .search(let keyword):
            return keyword.isEmpty ? "" : "'\(keyword)'"
        case .favorite:
            return "お気に入り"
        }
    }
}

protocol RepositoryListViewModel {

    var type: ListViewType { get }
    var repositoryList: RepositoryList { get }
    var repositories: Observable<[RepositoryEntity]> { get }
    func reloadRepositories()
}

final class SearchRepositoryListViewModel: RepositoryListViewModel {

    private let keyword: String
    private let output: RepositoryListOutputImplement
    let repositoryList: RepositoryList
    let type: ListViewType

    var repositories: Observable<[RepositoryEntity]> {
        output.remotePublisher
    }

    init(keyword: String, repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
        self.keyword = keyword
        self.type = .search(keyword: keyword)
    }

    func reloadRepositories() {
        repositoryList.remoteRepositories(relatedTo: keyword)
    }
}

final class FavoriteRepositoryListViewModel: RepositoryListViewModel {

    private let output: RepositoryListOutputImplement
    let repositoryList: RepositoryList
    let type: ListViewType

    private(set) var entities: [RepositoryEntity] = []

    var repositories: Observable<[RepositoryEntity]> {
        output.localPublisher
    }

    init(repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
        self.type = .favorite
    }

    func reloadRepositories() {
        repositoryList.localRepositories()
    }
}
