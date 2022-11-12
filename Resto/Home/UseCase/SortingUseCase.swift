//
//  SortingUseCase.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import Foundation

protocol SortUseCaseProtocol {
    func sortByName(input: [RestaurantModel]) -> [RestaurantModel]
}

class SortUseCase: SortUseCaseProtocol {
    func sortByName(input: [RestaurantModel]) -> [RestaurantModel] {
        input.sorted(by: { $0.name < $1.name })
    }
}
