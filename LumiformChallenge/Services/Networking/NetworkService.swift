//
//  NetworkService.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

/// Network service for making API requests
class NetworkService {
    /// The network client used for making requests
    private let client: NetworkClientProtocol
    
    // MARK: Initialization (Dependency Injection)
    
    /// - Parameter client: The network client implementation
    init(client: NetworkClientProtocol = URLSession.shared) {
        self.client = client
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    /// Fetches the page content from the API
    /// - Returns: The decoded Item model
    /// - Throws: NetworkError if the request fails
    func fetchPage() async throws -> Item {
        let url = Constants.API.pageURL
        let (data, response) = try await client.data(from: url)
        
        // Handle server error codes
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NetworkError.serverError(code: statusCode)
        }
        
        do {
            let page = try JSONDecoder().decode(Item.self, from: data)
            return page
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
