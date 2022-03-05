//
//  HTTPRequest.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

enum HTTPMethod: String {

    case GET
}

protocol AppRequest {

    associatedtype Response

    var baseURLString: String { get set }
    var method: HTTPMethod { get set }
    var queries: [URLQueryItem] { get set }
    var body: Data? { get set }
    var header: [String: String] { get set }
}

extension AppRequest {

    var method: HTTPMethod {
        .GET
    }

    var body: Data? {
        nil
    }

    var header: [String: String] {
        [:]
    }
}
