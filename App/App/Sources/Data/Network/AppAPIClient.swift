//
//  AppAPIClient.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

struct AppAPIClient {

    private let builder = URLRequestBuilder()

    @discardableResult
    func send<Converter: DataConverter>(
        _ appRequest: AppAPIRequest<Converter>,
        handlar: @escaping (Result<Converter.Object, NetworkError>) -> Void
    ) -> URLSessionTask? {
        guard let urlRequest = builder.build(appRequest) else {
            handlar(.failure(.invalideRequest))
            return nil
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            switch (data, response as? HTTPURLResponse, error) {
            case (.some(let data), .some(let httpResponse), .none):
                handlar(appRequest.parse(data, httpResponse))
            case (_, _, .some):
                handlar(.failure(.sessionError))
            default:
                handlar(.failure(.unknown))
            }
        }
        task.resume()
        return task
    }
}
