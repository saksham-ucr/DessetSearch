//
//  DetailModel.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/23/23.
//

import Foundation

// MARK: - DessertDetail
struct DessertDetail: Codable, Equatable {
    let meals: [MealDetail]
}

// MARK: - MealDetail
struct MealDetail: Codable, Equatable {
    let id, strMeal: String
    let strCategory, strArea, instructions: String
    let strMealThumb: String
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String
    let strIngredient13, strIngredient14, strIngredient15, strIngredient16: String
    let strIngredient17, strIngredient18, strIngredient19, strIngredient20: String
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4: String
    let strMeasure5, strMeasure6, strMeasure7, strMeasure8: String
    let strMeasure9, strMeasure10, strMeasure11, strMeasure12: String
    let strMeasure13, strMeasure14, strMeasure15, strMeasure16: String
    let strMeasure17, strMeasure18, strMeasure19, strMeasure20: String
    let strSource: String
    
    
}

// MARK: Ingredient List
extension MealDetail {
    var ingredientsDict: [String: String] {
        var dict: [String: String] = [:]
        let mirror = Mirror(reflecting: self)
        
        var i = 1
        while(true) {
            guard
                let ingredientValue = mirror.children.first(where: {$0.label == "strIngredient\(i)"})?.value as? String,
                ingredientValue != "",
                let measuredValue = mirror.children.first(where: {$0.label == "strMeasure\(i)"})?.value as? String
            else{
                return dict
            }
            dict[ingredientValue] = measuredValue
            i+=1
        }
    }
    
    var ingredientList: [String] {
        return self.ingredientsDict.map({key, value in "\(key): \(value)"})
    }
    
}

// MARK: - CodingKeys
extension MealDetail {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strCategory
        case strArea
        case instructions = "strInstructions"
        case strMealThumb
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        case strSource
    }
}
