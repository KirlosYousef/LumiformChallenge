//
//  MockNetworkService.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import Foundation
@testable import LumiformChallenge

struct MockNetworkService: NetworkServiceProtocol {
    let response: Item
    let error: Error?
    
    init(response: Item, error: Error? = nil) {
        self.response = response
        self.error = error
    }
    
    func fetchPage() async throws -> Item {
        if let error { throw error }
        return response
    }
}

struct MockDelayedNetworkService: NetworkServiceProtocol {
    let delay: TimeInterval
    
    func fetchPage() async throws -> Item {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        return MockPage.valid
    }
}


struct MockFailureNetworkService: NetworkServiceProtocol {
    func fetchPage() async throws -> Item {
        throw NetworkError.invalidURL
    }
}
