//
//  CacheManager.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
import SwiftUI
@testable import fetchMealSearch

final class CacheManagerTests: XCTestCase {
    
    var cacheManager: CacheManager!
    let testFolderName = "TestFolder"
    let testImageName = "xmark"
    
    override func setUp() {
        super.setUp()
        cacheManager = CacheManager.shared
    }
    
    override func tearDown() {
        cacheManager = nil
        super.tearDown()
    }
    
    /// Save Image and Get the same image in cache
    func test_saveimage_SaveAndGetImage_ImageFoundinCache() {
        // Create a mock test image
        let testImage = UIImage(systemName: testImageName)
        
        
        // Save the test image
        cacheManager.saveImage(image: testImage!, imageName: testImageName, folderName: testFolderName)
        
        // Retrieve the saved image
        let retrievedImage = cacheManager.getImage(imageName: testImageName, folderName: testFolderName)
        
        // Check if the retrieved image is not nil
        XCTAssertNotNil(retrievedImage)
        
        
        // Check if the retrieved image matches the original test image
        let data = testImage?.jpegData(compressionQuality: 0.8)
        XCTAssertEqual(UIImage(data: data!)?.pngData(), retrievedImage?.pngData())
    }
    
    /// No image saved in cache, will get nil
    func test_getImage_NoSavingImage_ImageNotFound() {
        
        // Try to retrieve an image that doesn't exist
        let retrievedImage = cacheManager.getImage(imageName: "NonexistentImage", folderName: testFolderName)
        
        // Check if the retrieved image is nil
        XCTAssertNil(retrievedImage)
    }
    
    
}
