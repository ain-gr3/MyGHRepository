//
//  RepositoryDetailViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/13.
//

import Foundation
import Domain
import RxSwift

final class RepositoryDetailViewModel {

    private let repositoryList: RepositoryList
    let repository: RepositoryEntity

    private let _isLiked = BehaviorSubject<Bool>(value: false)
    var isLiked: Observable<Bool> {
        _isLiked.asObservable()
    }

    init(repositoryList: RepositoryList, repository: RepositoryEntity) {
        self.repositoryList = repositoryList
        self.repository = repository

        self._isLiked.onNext(repository.isLiked)
        self.repository.output = { [weak self] isLiked in
            self?._isLiked.onNext(isLiked)
        }
    }

    func toggleIsLiked() {
        repositoryList.toggleIsLiked(of: repository)
    }
}
