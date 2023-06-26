//
//  UIApplication.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/21/23.
//

import Foundation
import SwiftUI


/// This is used to enable the 'x' sign in searchBar to resign the keyboard
extension UIApplication {
    func endEdititng() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

