//
//  HomeViewModelTests.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
@testable import fetchMealSearch

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var vm: HomeViewModel!
    var mockDataService: MockDataService<APIResponse>!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService<APIResponse>()
        vm = HomeViewModel(meal: [], searchText: "", ds: mockDataService, sort: .descending)
    }
    
    override func tearDown() {
        vm = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func test_fetch_SuccessfulFetch_SetsAllMealsRecievedAndFiltersAndSortsData() async throws {
        // Arrange
        let meals = [Meal(mealName: "Meal 1", mealThumb: "", id: "123"), Meal(mealName: "Meal 2", mealThumb: "", id: "124"), Meal(mealName: "Meal 3", mealThumb: "", id: "125")]
        let apiResponse = APIResponse(meals: meals)
        mockDataService.returnedData = apiResponse
        
        // Act
        await vm.fetch()
        
        // Assert
        XCTAssertTrue(mockDataService.fetchDataCalled)
        XCTAssertEqual(Set(vm.meal), Set(meals))
    }
    
    func test_fetch_FetchThrowsError_PrintsError() async {
        // Arrange
        let expectedError = NetworkManager.NetworkError.brokernURL
        mockDataService.thrownError = expectedError
        
        // Act
        
        await vm.fetch()
        
        //Asert
        XCTAssertTrue(mockDataService.fetchDataCalled)
    }
    
    func test_filterAndSortData_EmptySearchText_SortsAllMealsRecievedDescending() {
        // Arrange
        let meals = [Meal(mealName: "Meal 1", mealThumb: "", id: "123"), Meal(mealName: "Meal 2", mealThumb: "", id: "124"), Meal(mealName: "Meal 3", mealThumb: "", id: "125")]
        vm.allMealsRecieved = meals
        vm.sort = .descending
        
        // Act
        vm.filterAndSortData(text: "")
        
        // Assert
        XCTAssertEqual(vm.meal, meals.sorted { $0.mealName > $1.mealName })
    }
    
    func test_filterAndSortData_NonEmptySearchText_FiltersAndSortsAllMealsRecieved() {
        // Arrange
        let meals = [Meal(mealName: "Meal 1", mealThumb: "", id: "123"), Meal(mealName: "Meal 2", mealThumb: "", id: "124"), Meal(mealName: "Meal 3", mealThumb: "", id: "125")]
        
        vm.allMealsRecieved = meals
        vm.sort = .ascending
        
        // Act
        vm.filterAndSortData(text: "1")
        
        // Assert
        XCTAssertEqual(vm.meal, [Meal(mealName: "Meal 1", mealThumb: "", id: "123")])
    }
    
    func test_flipSort_CurrentSortIsAscending_ChangesSortToDescending() {
        // Arrange
        vm.sort = .ascending
        
        // Act
        vm.flipSort()
        
        // Assert
        XCTAssertEqual(vm.sort, .descending)
    }
    
    func test_flipSort_CurrentSortIsDescending_ChangesSortToAscending() {
        // Arrange
        vm.sort = .descending
        
        // Act
        vm.flipSort()
        
        // Assert
        XCTAssertEqual(vm.sort, .ascending)
    }
}
