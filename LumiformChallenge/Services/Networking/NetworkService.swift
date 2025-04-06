//
//  NetworkService.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

class NetworkService {
    private let client: NetworkClientProtocol
    
    // MARK: - Initialization (Dependency Injection)
    init(client: NetworkClientProtocol = URLSession.shared) {
        self.client = client
    }
}

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func fetchPage() async throws -> Item {
        guard let url = Constants.API.pageURL else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await client.data(from: url)
        
        // Handle server error codes
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let page = try JSONDecoder().decode(Item.self, from: data)
            return page
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingFailed
        }
    }
}
