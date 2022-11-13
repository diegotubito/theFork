//
//  RestaurantRepository.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation

typealias RestaurantResult = (Result<ResponseModel, ApiRequestError>) -> Void

protocol RestaurantRepositoryProtocol {
    func getRestaurants(completion: @escaping RestaurantResult)
}

class RestaurantRepository: ApiRequest, RestaurantRepositoryProtocol {
    func getRestaurants(completion: @escaping RestaurantResult) {
        apiCall { result in
            completion(result)
        }
    }
}

class RestaurantRepositoryMock: ApiRequestMock, RestaurantRepositoryProtocol {
    func getRestaurants(completion: @escaping RestaurantResult) {
        apiCallMocked { result in
            completion(result)
        }
    }
}

class RestaurantRepositoryFactory {
    static func create() -> RestaurantRepositoryProtocol {
        let testing = ProcessInfo.processInfo.arguments.contains("-uiTest")
        
        return testing ? RestaurantRepositoryMock() : RestaurantRepository()
    }
}
