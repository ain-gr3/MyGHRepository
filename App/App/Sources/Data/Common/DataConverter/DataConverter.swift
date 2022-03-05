//
//  DataConverter.swift
//  
//
//  Created by Ain Obara on 2022/03/06.
//

import Foundation

protocol DataConverter {

    associatedtype Object

    func decode(_ data: Data) throws -> Object
    func encode(_ object: Object) throws -> Data
}
