//
//  SearchViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import RxSwift
import RxRelay
import Domain

final class SearchViewModel {

    let text = BehaviorRelay<String?>(value: nil)

    let repositoryList: RepositoryList
    let output: RepositoryListOutputImplement

    init(repositoryList: RepositoryList, output: RepositoryListOutputImplement) {
        self.output = output
        self.repositoryList = repositoryList
    }

    var isButtonEnabled: Observable<Bool> {
        text
            .map { text in
                guard let text = text else {
                    return false
                }
                return !text.isEmpty
            }
    }

    func onChange(text: String?) {
        self.text.accept(text)
    }
}
