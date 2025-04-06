//
//  MainView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

/// Main content browser screen of the application
struct MainView: View {
    @StateObject private var viewModel = PageViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                contentView
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("Content Browser")
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK") { viewModel.removeError() }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown Error")
            }
            .task { loadData() }
            .refreshable { loadData() }
        }
    }
    
    /// The main content view based on data availability
    @ViewBuilder
    private var contentView: some View {
        if viewModel.page.isEmpty {
            UnavailableDataView(onRetry: loadData)
        } else {
            ContentListView(pageItems: viewModel.page)
        }
    }
    
    /// Loads page data from the API
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    MainView()
}
