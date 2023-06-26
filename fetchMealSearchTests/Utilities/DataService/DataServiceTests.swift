//
//  DataServiceTests.swift
//  fetchMealSearchTests
//
//  Created by user242726 on 6/25/23.
//

import XCTest
@testable import fetchMealSearch

class DataServiceTests: XCTestCase {
    
    var dataService: DataService<APIResponse>!
    var mockNetworkLayer: MockNetworkLayer!
    
    override func setUp() {
        super.setUp()
        mockNetworkLayer = MockNetworkLayer()
        dataService = DataService(networkManager: mockNetworkLayer)
    }
    
    override func tearDown() {
        dataService = nil
        mockNetworkLayer = nil
        super.tearDown()
    }
    /// Tests if good url is sent then we receive good response
    func test_getData_CorrectURL_GetDataSuccess() async {
        // Set up the mock response data
        
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Apam balik",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                    "idMeal": "53049"
                }
            ]
        }
        """
        
        mockNetworkLayer.responseData = json.data(using: .utf8)
        let responseData = try? JSONDecoder().decode(APIResponse.self, from: mockNetworkLayer.responseData!)
        do {
            let data = try await dataService.getData(url: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")
            
            XCTAssertEqual(responseData, data)
            
        } catch {
            XCTFail("Failed to get data with error: \(error)")
        }
    }
    
    /// Tests if Bad URL is sent , then we should receive an error
    func test_getData_BadURL_GetDataFailure() async {
        // Set up the mock error
        let error = NetworkManager.NetworkError.brokernURL
        mockNetworkLayer.responseError = error
        
        let url = ""
        
        do {
            _ = try await dataService.getData(url: url)
        
            XCTFail("Expected an error to be thrown")
        } catch let error as NetworkManager.NetworkError {
            XCTAssertEqual(error, NetworkManager.NetworkError.brokernURL)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
