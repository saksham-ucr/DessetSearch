//
//  HomeViewModel.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation
import AsyncAlgorithms
import SwiftUI

/// View Model for the home view
@MainActor
final class HomeViewModel: ObservableObject {
    
    var allMealsRecieved: [Meal]
    @Published private(set) var meal: [Meal]
    @Published var searchText: String
    @Published var sort: SortingOrder
    private let dataService: DataService<APIResponse>
    private var tasks = Set<TaskCancellable>()
    
    //MARK: Initialiser
    init(meal: [Meal] = [], searchText: String = "", ds: DataService<APIResponse> = DataService<APIResponse>(), sort: SortingOrder = .descending) {
        self.allMealsRecieved = meal
        self.meal = meal
        self.searchText = searchText
        self.dataService = ds
        self.sort = sort
        
        Task {
            for await (text, _) in combineLatest($searchText.values, $sort.values).debounce(for: .seconds(0.2)) {
                filterAndSortData(text: text)
            }
        }.store(in: &tasks)
    }
        
    //MARK: Fetch
    /// Fetches all the results
    func fetch() async {
        let url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        do {
            let data = try await dataService.getData(url: url)
            self.allMealsRecieved = data.meals
            filterAndSortData(text: "")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    // MARK: Filter and Sort
    /// Filters and sorts the data
    ///
    /// Sorts and filter the home view list
    /// - Parameter image: Search Bar string
    func filterAndSortData(text: String) {
        guard
            !text.isEmpty
        else {
            self.meal = allMealsRecieved.sorted(by: sort.getSortedFunction)
            return
        }
        
        self.meal = allMealsRecieved.filtered(with: text).sorted(by: sort.getSortedFunction)
        
    }
    
    
     
}

//MARK: Sorting Enum
/// SortingOrder declared
extension HomeViewModel {
    enum SortingOrder {
        case ascending
        case descending
        
        /// Funtion which returns the sorting function based on the value of the enum
        ///
        ///- Returns: (Meal, Meal) -> Bool
        var getSortedFunction: (_: Meal, _: Meal) -> Bool{
            switch self {
            case .ascending: return {$0.mealName < $1.mealName}
            case .descending: return {$0.mealName > $1.mealName}
            }
        }
        
        /// Function to get an icon based on the sorting order
        ///
        /// - Returns: Image, which has an icon based on the sorting
        var getIcon: Image {
            switch self {
            case .ascending: return Image(systemName:"chevron.up")
            case .descending: return Image(systemName: "chevron.down")
            }
        }
    }
        
    // MARK: Sort Button
    /// Flipping the sort order
    func flipSort() {
        if self.sort == .ascending {
            self.sort = .descending
        } else if self.sort == .descending {
            self.sort = .ascending
        }
    }
    
}
