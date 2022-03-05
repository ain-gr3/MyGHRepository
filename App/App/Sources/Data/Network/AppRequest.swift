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

extension AppRequest where Response: Decodable {

    func parse(_ data: Data, _ response: HTTPURLResponse) -> Result<Response, NetworkError> {
        do {
            switch response.statusCode {
            case 200...299:
                let object = try JSONDecoder.default.decode(Response.self, from: data)
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
