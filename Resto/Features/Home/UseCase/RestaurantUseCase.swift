//
//  RestaurantUseCase.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation

protocol RestaurantUseCaseProtocol {
    init(repository: RestaurantRepositoryProtocol)
    func getRestaurants(completion: @escaping RestaurantResult)
}

class RestaurantUseCase: RestaurantUseCaseProtocol {
    var repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol = RestaurantRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func getRestaurants(completion: @escaping RestaurantResult) {
        repository.getRestaurants { result in
            completion(result)
        }
    }
}
