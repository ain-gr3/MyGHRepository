//
//  AppJsonEncoder.swift
//  
//
//  Created by Ain Obara on 2022/03/05.
//

import Foundation

extension JSONEncoder {

    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
