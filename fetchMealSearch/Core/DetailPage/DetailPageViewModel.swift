//
//  DetailPageViewModel.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation

/// View Model for details page
@MainActor
final class DetailPageViewModel: ObservableObject {
    
    @Published var mealDetail: MealDetail? = nil
    @Published private(set) var isValidId: Bool
    let meal: Meal
    private let url: String
    private let dataService:DataService<DessertDetail>
    
    // MARK: Initialiser
    init(meal: Meal, ds: DataService<DessertDetail> = DataService<DessertDetail>()) {
        self.meal = meal
        self.url = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.id)"
        self.dataService = ds
        self.isValidId = true
       
    }
    
    /// Function which makes an API call for a certain dessert
    ///
    /// It sets the mealDetail variable of the view model
    func getData() async {
        do {
            let data = try await dataService.getData(url: self.url)
            self.mealDetail = data.meals[0]
            //print(self.meal)
        } catch {
            print(error.localizedDescription)
            self.isValidId = false
        }
    }
    
    
}
