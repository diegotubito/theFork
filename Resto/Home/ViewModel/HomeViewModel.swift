//
//  HomeViewModel.swift
//  Resto
//
//  Created by David Gomez on 10/11/2022.
//

import Foundation
protocol HomeViewModelProtocol {
    func fetchRestaurants()
    func loadImage(indexPath: IndexPath)
    var model: HomeModel { get set }
    
    var onSuccess: (() -> ())? { get set }
    var onError: ((String, String) -> ())? { get set }
    var onUpdatePhoto: ((IndexPath) -> Void)? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var model: HomeModel
    var onSuccess: (() -> ())?
    var onError: ((String, String) -> ())?
    var onUpdatePhoto: ((IndexPath) -> Void)?
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
                    for (index, _) in self.model.restaurants.enumerated() {
                        self.model.restaurants[index].imageState = .new
                    }
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
    
    func loadImage(indexPath: IndexPath) {
        switch model.restaurants[indexPath.row].imageState {
        case .new:
            guard let stringURL = model.restaurants[indexPath.row].mainPhoto?.photo_612x344, let url = URL(string: stringURL) else {
                model.restaurants[indexPath.row].imageState = .failed
                onUpdatePhoto?(indexPath)
                return
            }
            let concurrentPhotoQueue = DispatchQueue(label: "photoQueue", attributes: .concurrent)
            
            concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                do {
                    let imageData = try Data(contentsOf: url)
                    self.model.restaurants[indexPath.row].imageData = imageData
                    self.model.restaurants[indexPath.row].imageState = .downloaded
                    DispatchQueue.main.async {
                        self.onUpdatePhoto?(indexPath)
                    }
                } catch {
                    self.model.restaurants[indexPath.row].imageState = .failed
                }
            }
        case .downloaded, .failed, .none:
            break
        }
    }
}
