//
//  HomeViewModel.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation
protocol HomeViewModelProtocol {
    func fetchRestaurants()
    var model: HomeModel { get }
    func getModel() -> HomeModel
    
    var onSuccess: (() -> ())? { get set }
    var onError: ((String, String) -> ())? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var model: HomeModel
    var onSuccess: (() -> ())?
    var onError: ((String, String) -> ())?
    var restauranUseCase: RestaurantUseCaseProtocol
    
    init(repository: ApiRequest = ApiRequest() ) {
        self.restauranUseCase = RestaurantUseCase()
        self.model = HomeModel(restaurants: [])
    }
    
    func fetchRestaurants() {
        restauranUseCase.getRestaurants { result in
            switch result {
            case .success(let registers):
                DispatchQueue.main.async {
                    self.model.restaurants = registers.data
                    self.onSuccess?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.model.restaurants = []
                    self.onError?("Error", error.message)
                }
                break
            }
        }
    }
    
    func getModel() -> HomeModel {
        return model
    }
}
