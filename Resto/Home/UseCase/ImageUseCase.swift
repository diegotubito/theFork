//
//  ImageUseCase.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import Foundation

protocol ImageUseCaseProtocol {
    init(repository: ImageRepositoryProtocol)
    func loadImage(url: String, completion: @escaping ImageResult)
}

class ImageUseCase: ImageUseCaseProtocol {
    var repository: ImageRepositoryProtocol
    
    required init(repository: ImageRepositoryProtocol = ImageRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func loadImage(url: String, completion: @escaping ImageResult) {
        repository.loadImage(request: ImageEntity.Request(url: url)) { result in
            completion(result)
        }
    }
}
