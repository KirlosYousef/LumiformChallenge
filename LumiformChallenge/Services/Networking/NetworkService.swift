//
//  NetworkService.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

class NetworkService {
    private let client: NetworkClient
    
    init(client: NetworkClient = URLSession.shared) {
        self.client = client
    }
    
    func fetchHierarchy() async throws -> [Item] {
        guard let url = Constants.API.formHierarchyURL else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await client.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let items = try JSONDecoder().decode([Item].self, from: data)
            return items
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
