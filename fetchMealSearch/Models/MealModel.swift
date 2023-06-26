//
//  MealModel.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/23/23.
//

// MARK: - APIResponse
struct APIResponse: Codable,Equatable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Identifiable, Hashable, Equatable {
    let mealName: String
    let mealThumb: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case mealName = "strMeal"
        case mealThumb = "strMealThumb"
    }
}

