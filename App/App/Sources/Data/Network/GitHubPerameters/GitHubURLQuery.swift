//
//  GitHubURLQuery.swift
//  
//
//  Created by Ain Obara on 2022/03/06.
//

import Foundation

extension URLQueryItem {

    static func q(_ value: String) -> URLQueryItem {
        .init(name: "q", value: value)
    }
}
