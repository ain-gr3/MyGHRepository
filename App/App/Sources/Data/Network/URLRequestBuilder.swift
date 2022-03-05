//
//  URLRequestBuilder.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

struct URLRequestBuilder {

    func build<Request: AppRequest>(_ appRequest: Request) -> URLRequest? {
        var components = URLComponents(string: appRequest.baseURLString)
        components?.queryItems = appRequest.queries

        guard let url = components?.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = appRequest.method.rawValue
        urlRequest.httpBody = appRequest.body
        urlRequest.allHTTPHeaderFields = appRequest.header

        return urlRequest
    }
}
