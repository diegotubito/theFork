//
//  RestoTests.swift
//  RestoTests
//
//  Created by David Gomez on 12/11/2022.
//

import XCTest
@testable import Resto

final class SortUseCaseTests: XCTestCase {
    func test_sort_by_name() {
        // Given
        let useCase = SortUseCase()
        
        // When
        let result = useCase.sortByName(input: getMockInput())
        
        // Then
        XCTAssertTrue(result[0].name == "Restaurant A")
    }
    
    func test_sort_by_rating() {
        // Given
        let useCase = SortUseCase()
        
        // When
        let result = useCase.sortByRating(input: getMockInput())
        
        // Then
        XCTAssertTrue(result[0].name == "Restaurant Z")
    }
    
    private func getMockInput() -> [RestaurantModel] {
        let restaurantA = RestaurantModel(name: "Restaurant A",
                                          uuid: "",
                                          address: RestaurantModel.Address(street: "",
                                                                           postalCode: "",
                                                                           locality: "",
                                                                           country: ""),
                                          aggregateRatings: RestaurantModel.AgregateRating(thefork: RestaurantModel.RatingDetail(ratingValue: 9.1,
                                                                                                                                 reviewCount: 50)))
        
        let restaurantB = RestaurantModel(name: "Restaurant Z",
                                        uuid: "",
                                        address: RestaurantModel.Address(street: "",
                                                                         postalCode: "",
                                                                         locality: "",
                                                                         country: ""),
                                        aggregateRatings: RestaurantModel.AgregateRating(thefork: RestaurantModel.RatingDetail(ratingValue: 9.5,
                                                                                                                               reviewCount: 13)))
        return [restaurantA, restaurantB]
    }
}
