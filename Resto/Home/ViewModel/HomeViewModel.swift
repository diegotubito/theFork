//
//  HomeViewModel.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation
protocol HomeViewModelProtocol {
    func sortByName()
    func sortByRating()
    func fetchRestaurants()
    func loadImage(indexPath: IndexPath)
    func setFavourite(indexPath: IndexPath)
    var model: HomeModel { get set }
    var onError: ((String, String) -> ())? { get set }
    var onUpdatePhoto: ((IndexPath) -> Void)? { get set }
    var onUpdateTableViewList: (() -> Void)? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var model: HomeModel
    var onError: ((String, String) -> Void)?
    var onUpdatePhoto: ((IndexPath) -> Void)?
    var onUpdateTableViewList: (() -> Void)?
    var restauranUseCase: RestaurantUseCaseProtocol
    var sortUseCase: SortUseCaseProtocol
    var imageUseCase: ImageUseCaseProtocol
    
    init(repository: ApiRequest = ApiRequest() ) {
        self.restauranUseCase = RestaurantUseCase()
        self.sortUseCase = SortUseCase()
        self.imageUseCase = ImageUseCase()
        self.model = HomeModel(restaurants: [])
    }
    
    func fetchRestaurants() {
        restauranUseCase.getRestaurants { result in
            switch result {
            case .success(let registers):
                DispatchQueue.main.async {
                    self.model.restaurants = registers.data
                    for (index, _) in self.model.restaurants.enumerated() {
                        self.model.restaurants[index].imageState = .new
                    }
                    self.getIsFavourite()
                    self.sortByName()
                    self.onUpdateTableViewList?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.model.restaurants = []
                    self.onError?("Error", error.message)
                }
            }
        }
    }
 
    func loadImage(indexPath: IndexPath) {
        
        switch model.restaurants[indexPath.row].imageState {
        case .new:
            guard let stringURL = model.restaurants[indexPath.row].mainPhoto?.photo_612x344 else {
                model.restaurants[indexPath.row].imageState = .failed
                onUpdatePhoto?(indexPath)
                return
            }
            
            imageUseCase.loadImage(url: stringURL) { result in
                switch result {
                case .success(let data):
                    self.model.restaurants[indexPath.row].imageData = data
                    self.model.restaurants[indexPath.row].imageState = .downloaded
                    DispatchQueue.main.async {
                        self.onUpdatePhoto?(indexPath)
                    }
                case .failure:
                    self.model.restaurants[indexPath.row].imageState = .failed
                }
            }
        case .downloaded, .failed, .none:
            break
        }
    }
    
    func setFavourite(indexPath: IndexPath) {
        let uuid =  model.restaurants[indexPath.row].uuid
        let currentValue = UserDefaults.standard.object(forKey: uuid) as? Bool ?? false
        UserDefaults.standard.set(currentValue ? false : true, forKey: uuid)
        model.restaurants[indexPath.row].isFavourite = currentValue ? false : true
        self.onUpdatePhoto?(indexPath)
    }
    
    private func getIsFavourite() {
        for (index, restaurant) in model.restaurants.enumerated() {
            let currentValue = UserDefaults.standard.object(forKey: restaurant.uuid) as? Bool
            model.restaurants[index].isFavourite = currentValue
        }
    }
    
    func sortByName() {
        model.restaurants = sortUseCase.sortByName(input: model.restaurants)
        onUpdateTableViewList?()
    }
    
    func sortByRating() {
        model.restaurants = sortUseCase.sortByRating(input: model.restaurants)
        onUpdateTableViewList?()
    }
}
