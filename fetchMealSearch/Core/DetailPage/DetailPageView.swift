//
//  DetailPageView.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import SwiftUI

struct DetailPageView: View {
    
    @StateObject var vm: DetailPageViewModel
    
    init(meal: Meal) {
        self._vm = StateObject(wrappedValue: DetailPageViewModel(meal: meal))
        print(meal.mealName)
    }
    
    // MARK: BODY
    var body: some View {
        VStack {
            if let meal = vm.mealDetail {
                description(meal: meal)
                
            } else if !vm.isValidId {
                Text("Unable to fetch data")
                    .font(.title)
            } else {
                ProgressView()
            }
        }.navigationTitle(vm.meal.mealName)
        .task {
            await vm.getData()
        }
    }
    
    
    // MARK: - Description
    private func description(meal: MealDetail) -> some View{
        return ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                ImageView(meal: vm.meal)
                    .frame(height: 300)
                    .cornerRadius(20)
                
                Divider()
                
                Text("Ingredients").font(.largeTitle).underline()
                ForEach(meal.ingredientList.indices, id:\.self) { i  in
                    Text("\(i+1)) \(meal.ingredientList[i])")
                }
                
                Divider()
                
                Text("Instruction").font(.largeTitle).underline()
                Text(meal.instructions)
                
            }.padding()
        }
        
    }
}

struct DetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageView(meal: Meal(mealName: "Lorem Ipsum", mealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id:"53069"))
    }
}

