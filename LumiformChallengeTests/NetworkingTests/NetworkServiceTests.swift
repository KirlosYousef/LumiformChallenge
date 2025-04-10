//
//  NetworkServiceTests.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation
import Testing
@testable import LumiformChallenge

@Suite("Network service tests") struct NetworkServiceTests {
    struct SuccessTests {
        @Test("Test successful page fetch") func successfulFetch() async throws {
            // Arrange
            let mockData = try JSONEncoder().encode(MockPage.valid)
            let client = MockNetworkClient(data: mockData, statusCode: 200)
            let service = NetworkService(client: client)
            
            // Act
            let page = try await service.fetchPage()
            
            // Assert
            #expect(page.type == .page)
        }
    }
    
    struct FailureTests {
        @Test("Test server error handling") func serverErrorHandling() async {
            // Arrange
            let client = MockNetworkClient(data: Data(), statusCode: 500)
            let service = NetworkService(client: client)
            
            // Act/Assert
            await #expect(throws: NetworkError.serverError(code: 500)) {
                try await service.fetchPage()
            }
        }
        
        @Test("Test decoding failure") func decodingFailure() async {
            // Arrange
            let invalidJSON = Data("{\"invalid\": \"data\"}".utf8)
            let client = MockNetworkClient(data: invalidJSON, statusCode: 200)
            let service = NetworkService(client: client)
            
            // Act/Assert
            await #expect(throws: NetworkError.decodingFailed) {
                try await service.fetchPage()
            }
        }
    }
}
