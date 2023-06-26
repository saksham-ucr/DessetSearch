//
//  MockDataService.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//
import Foundation
@testable import fetchMealSearch

class MockDataService<T: Decodable>: DataService<T> {
    
    var fetchDataCalled = false
    var returnedData: T?
    var thrownError: Error?
    
    override func getData(url: String) async throws -> T {
        fetchDataCalled = true
        if let error = thrownError {
            throw error
        }
        
        return returnedData!
    }
}

