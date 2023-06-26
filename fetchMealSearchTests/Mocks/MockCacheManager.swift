//
//  MockCacheManager.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import Foundation
import SwiftUI
@testable import fetchMealSearch

// MARK: - Mock Cache Layer
final class MockCacheLayer: CacheLayer {
    
    var savedImage: UIImage?
    var getImageCalled = false
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        savedImage = image
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        getImageCalled = true
        return savedImage
    }
}
