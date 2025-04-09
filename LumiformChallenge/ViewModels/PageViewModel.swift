//
//  PageViewModel.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import SwiftUI
import RealmSwift

/// View model for managing page content data
/// Handles data loading, caching, and state management
@MainActor
class PageViewModel: ObservableObject {
    // MARK: - Published Properties
    
    /// Indicates if data is currently being loaded
    @Published private(set) var isLoading = false
    
    /// Indicates if there is an error to display
    @Published var hasError: Bool = false
    
    /// The error message to display to the user
    @Published private(set) var errorMessage: String? {
        didSet {
            hasError = errorMessage != nil
        }
    }
    
    // MARK: - Dependencies
    
    /// Service for network operations
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initialization (Dependency Injection)
    
    /// Initializes the view model with dependencies
    /// - Parameter networkService: The service used for network operations
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Data Loading
    
    /// Loads page data from the network API and updates local cache in Realm
    func loadData() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            if try await !hasForceState() {
                // Network call and processing in background
                let networkPage = try await Task.detached(priority: .background) {
                    try await self.networkService.fetchPage().withDepthLevels()
                }.value
                
                let realmItem = RealmItem(item: networkPage, isRootPage: true)
                await RealmService.shared.overwrite(item: realmItem)
            }
        } catch {
            errorMessage = handleError(error)
        }
    }
    
    /// - Returns: The root Item if available, nil otherwise
    func getPageItem() async -> Item? {
        RealmService.shared.getRealmItems().first?.item
    }
    
    // MARK: - Error Handling
    
    /// Clears the current error message
    func removeError() {
        errorMessage = nil
    }
    
    /// Handles errors and returns appropriate error messages
    /// - Parameter error: The error to handle
    /// - Returns: A user-friendly error message
    private func handleError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.localizedDescription
        }
        return "An unexpected error occurred: \(error.localizedDescription)"
    }
    
    
}

// MARK: - Force state for UITestings
extension PageViewModel {
    /// Checks for any force state for the UITestings
    private func hasForceState() async throws -> Bool {
        let processInfo = ProcessInfo.processInfo
        
        if processInfo.isUITesting {
            let realm = RealmService.shared
            
            if processInfo.useMockData && !processInfo.forceEmptyState { // Use mock data
                let realmItem = RealmItem(item: MockPage.valid, isRootPage: true)
                await realm.overwrite(item: realmItem)
            }
            
            if processInfo.forceEmptyState { // Force empty state
                await realm.removeAll()
            } else if processInfo.forceErrorState {  // Force error state
                errorMessage = handleError(NetworkError.invalidURL)
            } else if processInfo.forceLoadingState {  // Force loading state
                try await Task.sleep(nanoseconds: 10_000_000_000)
            }
            
            return true
        }
        
        return false
    }
}
