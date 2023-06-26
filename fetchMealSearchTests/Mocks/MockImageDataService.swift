//
//  MockImageDataService.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import Foundation
import SwiftUI
@testable import fetchMealSearch

final class MockImageDataService: ImageDataService {
    var getImageCalled = false
    var returnedImage: UIImage?
    var thrownError: Error?
    
    override func getImage() async throws -> UIImage? {
        getImageCalled = true
        
        if let error = thrownError {
            throw error
        }
        
        return returnedImage
    }
}
