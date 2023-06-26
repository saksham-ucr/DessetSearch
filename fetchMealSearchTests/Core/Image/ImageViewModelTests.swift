//
//  ImageViewModelTests.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
@testable import fetchMealSearch

@MainActor
final class ImageViewModelTests: XCTestCase {
    
    var vm: ImageViewModel!
    var mockDataService: MockImageDataService!
    
    override func setUp() {
        super.setUp()
        let meal = Meal(mealName: "Meal 1", mealThumb: "", id: "123")
        vm = ImageViewModel(meal: meal)
        mockDataService = MockImageDataService(meal: meal)
        vm.dataService = mockDataService
    }
    
    override func tearDown() {
        vm = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func test_getImage_SuccessfulImageDownload_SetsImage() async {
        // Arrange
        let image = UIImage(systemName: "xmark")!
        mockDataService.returnedImage = image
        
        // Act
        await vm.getImage()
        
        // Assert
        XCTAssertTrue(mockDataService.getImageCalled)
        XCTAssertEqual(vm.image, image)
    }
    
    func test_getImage_ImageDownloadThrowsError_PrintsError() async {
        // Arrange
        let error = NetworkManager.NetworkError.badServerResponse
        mockDataService.thrownError = error
        
        // Act
        await vm.getImage()
        
        // Assert
        XCTAssertTrue(mockDataService.getImageCalled)
        
    }
}
