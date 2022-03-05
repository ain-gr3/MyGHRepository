//
//  AppHTTPHeader.swift
//  
//
//  Created by Ain Obara on 2022/03/06.
//

import Foundation

struct AppHTTPHeader {

    let key: String
    let value: String
}

extension Array where Element == AppHTTPHeader {

    func convertToDictionary() -> [String: String] {
        return Dictionary(uniqueKeysWithValues: self.map { ($0.key, $0.value)})
    }
}
