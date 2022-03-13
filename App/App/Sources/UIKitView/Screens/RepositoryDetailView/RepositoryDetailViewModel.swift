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
    private let output: RepositoryListOutputImplement
    let repository: RepositoryEntity

    var isLiked: Observable<Bool> {
        output.updatedRepositoryPublisher
            .filter { [weak self] updated in
                updated == self?.repository
            }
            .map { $0.isLiked }
    }

    init(repositoryList: RepositoryList, output: RepositoryListOutputImplement, repository: RepositoryEntity) {
        self.repositoryList = repositoryList
        self.repository = repository
        self.output = output
    }

    func toggleIsLiked() {
        repositoryList.toggleIsLiked(of: repository)
    }
}
