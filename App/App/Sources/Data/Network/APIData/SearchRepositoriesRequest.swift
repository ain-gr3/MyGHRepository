//
//  SearchRepositoriesRequest.swift
//  
//
//  Created by Ain Obara on 2022/03/06.
//

import Foundation

struct SearchRepositoriesDecoder: DataDecoder {
    typealias Object = SearchRepositoryResponse
}

extension AppAPIRequest where Decoder == SearchRepositoriesDecoder {

    static func searchRepositories(searchWord: String) -> Self {
        .init(
            baseURLString: "https://api.github.com/search/repositories",
            method: .GET,
            queries: [.q(searchWord)],
            body: nil,
            header: [.application],
            decoder: SearchRepositoriesDecoder()
        )
    }
}
