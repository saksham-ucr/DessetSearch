//
//  NetworkManager.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/21/23.
//

import Foundation

// MARK: Network layer used for testing
protocol NetworkLayer {
    func fetch(url: String) async throws -> Data
}

// MARK: Network Manager
final class NetworkManager: NetworkLayer {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    /// Responsible for making API Calls
    ///
    /// - Parameter url: String which contains the API url
    /// - Returns: Data which need to be decoded by the caller
    func fetch(url: String) async throws -> Data {
        
        guard let url = URL(string: url)
        else {throw NetworkError.brokernURL}
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let res = response as? HTTPURLResponse,
              res.statusCode >= 200 && res.statusCode < 300
        else {throw NetworkError.badServerResponse}
        return data
    }
}

// MARK: Error
extension NetworkManager {
    
    /// Errors used for Network Manger
    enum NetworkError: LocalizedError {
        case brokernURL
        case badServerResponse
        
        var errorDescription: String? {
            switch self {
            case .brokernURL: return "Borken URL"
            case .badServerResponse: return "Bad Server Response"
            }
        }
    }
}
