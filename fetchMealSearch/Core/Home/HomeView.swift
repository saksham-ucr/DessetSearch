//
//  HomeView.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/21/23.
//

import SwiftUI


/// Home View
struct HomeView: View {
    
    @StateObject var vm: HomeViewModel = HomeViewModel()
   
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                SearchBarView(searchString: $vm.searchText)
                SortButton
                List {
                    ForEach(vm.meal) { meal in
                        NavigationLink(value: meal) {
                            HomeRowView(meal: meal)
                        }
                    }
                }
                .listStyle(.plain)
                .background(.white)
                .padding(.top, 8)
                .navigationDestination(for: Meal.self, destination: { val in
                    DetailPageView(meal: val)
                })
                .task {
                    await vm.fetch()
                }
            }
        }
    }
    
    /// Sort Button
    private var SortButton: some View {
        HStack {
            Spacer()
            HStack{
                vm.sort.getIcon
                Text("Sort")
            }.padding(.horizontal, 10)
                .foregroundColor(.accentColor)
                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                .padding(.horizontal)
                .onTapGesture {
                    vm.flipSort()
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
        }
    }
}
