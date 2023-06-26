//
//  DetailPageViewModelTests.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
@testable import fetchMealSearch

// MARK: - Unit Tests

@MainActor
final class DetailPageViewModelTests: XCTestCase {
    
    var vm: DetailPageViewModel!
    var mockDataService: MockDataService<DessertDetail>!
    var meal: Meal!
    
    override func setUp() {
        super.setUp()
        
        mockDataService = MockDataService<DessertDetail>()
        meal = Meal(mealName: "lorem", mealThumb: "https://example.com/meal.jpg", id: "123")
        
        vm = DetailPageViewModel(meal: meal, ds: mockDataService)
        
    }
    
    override func tearDown() {
        vm = nil
        mockDataService = nil
        meal = nil
        
        super.tearDown()
    }
    
    func test_init_ValidatesId_validIDShouldBeTrue() {
        // Assert
        XCTAssertTrue(vm.isValidId)
    }
        
    func test_getData_FetchDataThrowsError_SetsIsValidIdToFalse() async throws {
        // Arrange
        let expectedError = NetworkManager.NetworkError.badServerResponse
        mockDataService.thrownError = expectedError
        
        // Act
        await vm.getData()
        
        // Assert
        XCTAssertTrue(mockDataService.fetchDataCalled)
        XCTAssertFalse(vm.isValidId)
    }
    
    func test_getData_FetchDataSuccessfully_SetsMealDetail() async throws {
        // Arrange
        let returnedData = DessertDetail(meals: [MealDetail(id: "", strMeal: "", strCategory: "", strArea: "", instructions: "", strMealThumb: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15:  "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "")])
        
        mockDataService.returnedData = returnedData
        
        // Act
        await vm.getData()
        
        // Assert
        XCTAssertTrue(mockDataService.fetchDataCalled)
        XCTAssertEqual(vm.mealDetail, returnedData.meals[0])
    }
    
    func test_getData_FetchDataThrowsError_SetsMealDetailToNil() async throws {
        // Arrange
        mockDataService.thrownError = NetworkManager.NetworkError.badServerResponse
        
        // Act
        await vm.getData()
        
        // Assert
        XCTAssertTrue(mockDataService.fetchDataCalled)
        XCTAssertNil(vm.mealDetail)
    }
    
}
