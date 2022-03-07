//
//  SearchViewModel.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import RxSwift
import RxRelay

final class SearchViewModel {

    let text = BehaviorRelay<String?>(value: nil)

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
