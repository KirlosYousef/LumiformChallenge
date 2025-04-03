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
    @Published private(set)var page: Item? = nil
    @Published private(set)var isLoading = false
    
    @Published var hasError: Bool = false
    @Published private(set)var errorMessage: String? {
        didSet {
            hasError = errorMessage != nil
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
            self.page = networkPage.withDepthLevels()
            // TODO: Save to cache
        } catch {
            errorMessage = handleError(error)
            // TODO: Fallback to cached data
        }
    }
    
    // MARK: - Error Handling
    func removeError() {
        errorMessage = nil
    }
    
    private func handleError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.localizedDescription
        }
        return "An unexpected error occurred: \(error.localizedDescription)"
    }
}
