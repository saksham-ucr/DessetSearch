//
//  ImageView.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import SwiftUI

/// Image view, used multiple times in home screen and detailed page view as well
struct ImageView: View {
    
    @StateObject var vm: ImageViewModel
    
    init(meal: Meal) {
        self._vm = StateObject(wrappedValue: ImageViewModel(meal: meal))
    }
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }.task {
            await vm.getImage()
        }
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(meal: Meal(mealName: "Lorem Ipsum", mealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id:"1234"))
    }
}
