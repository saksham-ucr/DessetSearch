//
//  RowView.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import SwiftUI

/// Row view on the home screen
struct HomeRowView: View {
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        HStack(spacing: 20) {
            ImageView(meal: self.meal)
                .frame(width: 50, height: 50)
                .cornerRadius(20)
            Text(meal.mealName)
                .font(.title3)
                .lineLimit(1)
        }.font(.title2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRowView(meal: Meal(mealName: "Lorem Ipsum", mealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id:"1234"))
    }
}
