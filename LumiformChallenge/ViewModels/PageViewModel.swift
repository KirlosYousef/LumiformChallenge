//
//  PageViewModel.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import SwiftUI
import RealmSwift

@MainActor
class PageViewModel: ObservableObject {
    // MARK: - Published Properties
    @ObservedResults(RealmItem.self) var page
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
    /// Loads the data from network and updates the current caching on Realm
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Network call and processing in background
            let networkPage = try await Task.detached(priority: .background) {
                try await self.networkService.fetchPage().withDepthLevels()
            }.value
            
            let realmItem = RealmItem(item: networkPage, isRootPage: true)
            let realm = try await Realm()
            
            try! realm.write {
                realm.deleteAll()
                realm.add(realmItem)
            }
        } catch {
            errorMessage = handleError(error)
        }
    }
    
    /// Returns back the current page item from Realm
    func getPageItem() async -> Item? {
        do {
            let realm = try await Realm()
            let page: Item? = realm.objects(RealmItem.self).first?.item
            return page
        } catch {
            errorMessage = handleError(error)
        }
        
        return nil
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
