//
//  DataService.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/23/23.
//

import Foundation
import SwiftUI

/// Generic data service for downloading JSON data
class DataService<T: Decodable> {
    
    let networkManager: NetworkLayer
    
    init(networkManager: NetworkLayer = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getData(url: String) async throws -> T {
        do{
            let returnedData = try await networkManager.fetch(url: url)
            dump(returnedData)
            let data = try JSONDecoder().decode(T.self, from: returnedData)
            return data
            
        } catch let err {
            throw err
        }
    }
}
