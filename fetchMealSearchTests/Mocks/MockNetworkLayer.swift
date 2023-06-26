//
//  MockNetworkLayer.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import Foundation
@testable import fetchMealSearch

// MARK: Mock Network Layer
final class MockNetworkLayer: NetworkLayer {
    
    var responseData: Data?
    var responseError: Error?
    
    func fetch(url: String) async throws -> Data {
        guard
            let _ = URL(string: url)
        else{throw responseError!}
        
        if let err = responseError {
            throw err
        }
        
        return responseData!
    }
}
