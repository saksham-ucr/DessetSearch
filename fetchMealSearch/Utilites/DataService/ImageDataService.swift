//
//  ImageDataService.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation
import SwiftUI

class ImageDataService {
    
    private let networkManager: NetworkLayer
    private let cacheManager: CacheLayer
    private let meal: Meal
    private let folderName: String
    
    init(networkManager: NetworkLayer = NetworkManager.shared,
         cacheManager: CacheLayer = CacheManager.shared, folderName:String = "Fetch_Rewards", meal: Meal) {
        
        self.networkManager = networkManager
        self.cacheManager = cacheManager
        self.meal = meal
        self.folderName = folderName
    }
    
    /// Function to get image
    ///
    /// First it checks if the image is already cached by the FileManager, and if not it downloads the image and stores it
    ///
    ///- Returns: UIImage
    func getImage() async throws -> UIImage? {
        
        // Find saved image
        
        if let savedImage = cacheManager.getImage(imageName: meal.id, folderName: self.folderName) {
            // Image was already saved in the cache
            return savedImage
        } else {
            // No image found going to download it
            return try await downloadImage()
        }
    }
    
    /// Function to download the image
    ///
    /// If the image os not already downloaded this method is called
    ///
    /// - Returns: UIImage
    private func downloadImage() async throws -> UIImage?{
        
        let returnedData = try await networkManager.fetch(url: meal.mealThumb)
        
        if let image = UIImage(data: returnedData) {
            
            cacheManager.saveImage(image: image, imageName: meal.id, folderName: self.folderName)
            
            return image
        }
        
        return nil
        
    }
}
