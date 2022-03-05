//
//  AppAPIRequest.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

enum HTTPMethod: String {

    case GET
}

struct AppAPIRequest<Converter: DataConverter> {

    let baseURLString: String
    let method: HTTPMethod
    let queries: [URLQueryItem]
    let body: Data?
    let header: [String: String]

    let dataConverter: Converter

    func parse(_ data: Data, _ response: HTTPURLResponse) -> Result<Converter.Object, NetworkError> {
        do {
            switch response.statusCode {
            case 200...299:
                let object = try dataConverter.decode(data)
                return .success(object)
            case 400...499:
                return .failure(NetworkError.serverError)
            default:
                return .failure(NetworkError.unknown)
            }
        } catch {
            return .failure(NetworkError.invalideResponse)
        }
    }
}
