//
//  RepositoryListViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Foundation
import Domain
import RxSwift
import RxRelay

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
    var output: RepositoryListOutputImplement { get }
    var repositories: Observable<[RepositoryEntity]> { get }
    var state: Observable<ListViewState> { get }
    func reloadRepositories()
}

final class SearchRepositoryListViewModel: RepositoryListViewModel {

    private let keyword: String
    let output: RepositoryListOutputImplement
    let repositoryList: RepositoryList
    let type: ListViewType

    private let desposeBag = DisposeBag()

    var repositories: Observable<[RepositoryEntity]> {
        output.remotePublisher
            .asObservable()
    }

    private let _state = PublishRelay<ListViewState>()
    var state: Observable<ListViewState> {
        _state
            .asObservable()
    }

    init(keyword: String, repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
        self.keyword = keyword
        self.type = .search(keyword: keyword)

        output.errorPublisher
            .map { _ -> ListViewState in .hasError(.cannotGetContents)}
            .bind(to: _state)
            .disposed(by: desposeBag)
        output.remotePublisher
            .map { repositories -> ListViewState in
                repositories.isEmpty ? .hasError(.noContents) : .normal
            }
            .bind(to: _state)
            .disposed(by: desposeBag)
    }

    func reloadRepositories() {
        repositoryList.remoteRepositories(relatedTo: keyword)
        _state.accept(.isLoading)
    }
}

final class FavoriteRepositoryListViewModel: RepositoryListViewModel {

    let output: RepositoryListOutputImplement
    let repositoryList: RepositoryList
    let type: ListViewType

    private let desposeBag = DisposeBag()

    var repositories: Observable<[RepositoryEntity]> {
        output.localPublisher
            .asObservable()
    }

    private let _state = PublishRelay<ListViewState>()
    var state: Observable<ListViewState> {
        _state
            .asObservable()
    }

    init(repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.repositoryList = repositoryList
        self.output = output
        self.type = .favorite

        output.errorPublisher
            .map { _ -> ListViewState in .hasError(.cannotGetContents)}
            .bind(to: _state)
            .disposed(by: desposeBag)
        output.localPublisher
            .map { repositories -> ListViewState in
                repositories.isEmpty ? .hasError(.noContents) : .normal
            }
            .bind(to: _state)
            .disposed(by: desposeBag)
    }

    func reloadRepositories() {
        repositoryList.localRepositories()
    }
}
