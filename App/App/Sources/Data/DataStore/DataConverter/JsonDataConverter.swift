//
//  JsonDataConverter.swift
//  
//
//  Created by Ain Obara on 2022/03/05.
//

import Foundation

extension DataConverter where Object: Decodable {

    func decode(_ data: Data) throws -> Object {
        let decoder = JSONDecoder.default
        let object = try decoder.decode(Object.self, from: data)
        return object
    }
}

extension DataConverter where Object: Encodable {

    func encode(_ object: Object) throws -> Data {
        let encoder = JSONEncoder.default
        return try encoder.encode(object)
    }
}
