//
//  ApiRequestMock.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation

class ApiRequestMock {
    var mockFileName: String = ""
    var success: Bool = true
    
    init() {}
    
    var error: ApiRequestError?
    
    func apiCallMocked<T: Decodable>(completionBlock: @escaping (Result<T, ApiRequestError>) -> Void) {
        let filenameFromTestingTarget = ProcessInfo.processInfo.environment["FILENAME"] ?? ""
        if !filenameFromTestingTarget.isEmpty {
            mockFileName = filenameFromTestingTarget
        }
        
        let testFail = ProcessInfo.processInfo.arguments.contains("-testFail")
        if testFail {
            success = testFail
        }
        
        guard let data = readLocalFile(bundle: .main, forName: mockFileName) else {
            completionBlock(.failure(ApiRequestError.notFound))
            return
        }
        
        if !success {
            completionBlock(.failure(.notFound))
            return
        }
        
        guard let register = try? JSONDecoder().decode(T.self, from: data) else {
            completionBlock(.failure(.serialize(identifier: String(describing: T.self))))
            return
        }
        
        completionBlock(.success(register))
    }
    
    private func readLocalFile(bundle: Bundle, forName name: String) -> Data? {
        guard let bundlePath = bundle.path(forResource: name, ofType: "json") else {
            fatalError("file \(name).json doesn't exist")
        }
        
        return try? String(contentsOfFile: bundlePath).data(using: .utf8)
    }
}

