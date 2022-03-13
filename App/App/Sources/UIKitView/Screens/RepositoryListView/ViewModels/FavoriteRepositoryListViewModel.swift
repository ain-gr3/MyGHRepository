//
//  FavoriteRepositoryListViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/13.
//

import Domain
import RxSwift
import RxRelay

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
