//
//  PageViewModel.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import SwiftUI

@MainActor
class PageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var page: Item? = nil
    @Published var isLoading = false
    
    @Published var hasError: Bool = false
    @Published var errorMessage: String? {
        didSet {
            hasError = true
        }
    }
    
    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initialization (Dependency Injection)
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Data Loading
    func loadData() async {
        isLoading = true
        defer { isLoading = false } // Guaranteed to execute after function completes
        
        do {
            // Try network first
            let networkPage = try await networkService.fetchPage()
            page = networkPage
            // TODO: Save to cache
        } catch {
            errorMessage = handleError(error)
            // TODO: Fallback to cached data
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.localizedDescription
        }
        return "An unexpected error occurred: \(error.localizedDescription)"
    }
}
