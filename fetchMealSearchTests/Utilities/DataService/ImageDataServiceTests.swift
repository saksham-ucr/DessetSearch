//
//  ImageDataServiceTests.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
@testable import fetchMealSearch

class ImageDataServiceTests: XCTestCase {
    
    var imageDataService: ImageDataService!
    var mockNetworkLayer: MockNetworkLayer!
    var mockCacheLayer: MockCacheLayer!
    var meal: Meal!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkLayer = MockNetworkLayer()
        mockCacheLayer = MockCacheLayer()
        
        meal = Meal(mealName: "lorem", mealThumb: "https://example.com/image.jpg", id:"1234")
        
        imageDataService = ImageDataService(networkManager: mockNetworkLayer, cacheManager: mockCacheLayer, meal: meal)
    }
    
    override func tearDown() {
        imageDataService = nil
        mockNetworkLayer = nil
        mockCacheLayer = nil
        meal = nil
        
        super.tearDown()
    }
    
    func test_getImage_CachedImageExists_ReturnsCachedImage() async throws {
        // Arrange
        let cachedImage = UIImage(systemName: "xmark")
        mockCacheLayer.savedImage = cachedImage
        
        // Act
        let result = try await imageDataService.getImage()
        
        // Assert
        XCTAssertTrue(mockCacheLayer.getImageCalled)
        XCTAssertEqual(result, cachedImage)
    }
    
    func test_getImage_NoCachedImage_DownloadsAndSavesImage() async throws {
        // Arrange
        let downloadedImage = UIImage(systemName: "xmark")
        mockNetworkLayer.responseData = downloadedImage?.pngData()
        
        // Act
        let _ = try await imageDataService.getImage()
        
        // Assert
        XCTAssertTrue(mockCacheLayer.getImageCalled)
        XCTAssertNotNil(mockCacheLayer.savedImage)
    }
    
    func test_getImage_NetworkError_ThrowsError() async throws {
        // Arrange
        let expectedError = NetworkManager.NetworkError.badServerResponse
        mockNetworkLayer.responseError = expectedError
        
        do{
            // Act
            let _ = try await imageDataService.getImage()
        } catch {
            // Assert
            XCTAssertEqual(error as? NetworkManager.NetworkError , expectedError)
        }
    
    }
}



