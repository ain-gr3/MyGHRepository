//
//  SearchRepositoryListViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/13.
//

import Domain
import RxSwift
import RxRelay

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
