//
//  ImageRepository.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import Foundation

typealias ImageResult = (Result<Data, ApiRequestError>) -> Void

struct ImageEntity {
    struct Request {
        var url: String
    }
}

protocol ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request, completion: @escaping ImageResult)
}

class ImageRepository: ApiRequest, ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request, completion: @escaping ImageResult) {
        loadImage(stringUrl: request.url) { result in
            completion(result)
        }
    }
}

class ImageRepositoryMock: ApiRequestMock, ImageRepositoryProtocol {
    func loadImage(request: ImageEntity.Request, completion: @escaping ImageResult) {
        loadImageMock { result in
            completion(result)
        }
    }
}

class ImageRepositoryFactory {
    static func create() -> ImageRepositoryProtocol {
        let testing = ProcessInfo.processInfo.arguments.contains("-uiTest")
        
        return testing ? ImageRepositoryMock() : ImageRepository()
    }
}
