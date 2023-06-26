//
//  ImageViewModel.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation
import SwiftUI

/// View Model for loading images
@MainActor
class ImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    private let meal: Meal
    var dataService: ImageDataService
    
    // MARK: Initialiser
    init(meal: Meal) {
        self.meal = meal
        dataService = ImageDataService(meal: meal)
    }
    
    
    /// Function to get image using the Image data service
    func getImage() async {
        do {
            self.image = try await dataService.getImage()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
