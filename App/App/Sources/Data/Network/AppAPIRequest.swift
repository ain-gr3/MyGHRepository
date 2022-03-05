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

struct AppAPIRequest<Decoder: DataDecoder> {

    let baseURLString: String
    let method: HTTPMethod
    let queries: [URLQueryItem]
    let body: Data?
    let header: [String: String]

    let decoder: Decoder

    func parse(_ data: Data, _ response: HTTPURLResponse) -> Result<Decoder.Object, NetworkError> {
        do {
            switch response.statusCode {
            case 200...299:
                let object = try decoder.decode(data)
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
