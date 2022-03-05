//
//  SearchRepositoriesResponse.swift
//  
//
//  Created by Ain Obara on 2022/03/06.
//

import Foundation
import Domain

struct SearchRepositoryResponse: Decodable {

    let items: [RepositoryData]
}
