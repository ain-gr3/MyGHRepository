//
//  AppFileManager.swift
//  
//
//  Created by Ain Obara on 2022/03/05.
//

import Foundation

struct AppFileManager<Converter: DataConverter> {

    private let fileManager: FileManager
    private let dataConverter: Converter

    func getContents(at directory: AppDirectory, fileName: String) -> Result<Converter.Object, FileManagerError> {
        guard let data = fileManager.contents(atPath: directory.path + fileName) else {
            return .failure(.noSuchFile)
        }
        do {
            let object = try dataConverter.decode(data)
            return .success(object)
        } catch {
            return .failure(.invalidDataStructure)
        }
    }

    func save(_ fileName: String, at directory: AppDirectory, object: Converter.Object) -> Result<Void, FileManagerError> {
        do {
            let data = try dataConverter.encode(object)
            fileManager.createFile(atPath: directory.path + fileName, contents: data)
            return .success(())
        } catch {
            return .failure(.cannotEncode)
        }
    }
}

extension AppFileManager {

    init(dataConverter: Converter) {
        self.init(fileManager: FileManager(), dataConverter: dataConverter)
    }
}
