//
//  Array.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/21/23.
//

import Foundation

/// Custom function defined for Meal array
extension Array where Element == Meal {
    func filtered(with searchText: String) -> [Meal] {
        self.filter({$0.mealName.lowercased().contains(searchText.lowercased())})
    }
}
