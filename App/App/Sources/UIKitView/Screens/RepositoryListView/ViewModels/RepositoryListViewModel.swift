//
//  RepositoryListViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/12.
//

import Domain
import RxSwift
import RxRelay

protocol RepositoryListViewModel {

    var type: ListViewType { get }
    var repositoryList: RepositoryList { get }
    var output: RepositoryListOutputImplement { get }
    var repositories: Observable<[RepositoryEntity]> { get }
    var state: Observable<ListViewState> { get }
    func reloadRepositories()
}
