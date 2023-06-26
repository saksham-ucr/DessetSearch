//
//  searchBarView.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/21/23.
//

import SwiftUI

/// Search Bar rendered on the home screen
struct SearchBarView: View {
    
    @Binding var searchString: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.trailing)
                //.foregroundColor(.white)
            
            TextField("Enter your meal...",
                      text: $searchString)
                //.foregroundColor(.white)
                .overlay(
                    Image(systemName: "xmark.circle")
                        //.foregroundColor(.white)
                        .padding()
                        .offset(x: 10)
                        .opacity(searchString.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchString = ""
                            UIApplication.shared.endEdititng()
                        }
                    , alignment: .trailing
                )
        }
        .font(.title2)
        .padding(.all, 20)
        .foregroundColor(.accentColor)
        .background(RoundedRectangle(cornerRadius: 25).fill(.white))
        .padding()
        
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchString: .constant(""))
    }
}
