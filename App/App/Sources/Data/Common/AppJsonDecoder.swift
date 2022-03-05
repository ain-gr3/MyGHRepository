//
//  AppJsonDecoder.swift
//  
//
//  Created by Ain Obara on 2022/03/04.
//

import Foundation

extension JSONDecoder {

    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
