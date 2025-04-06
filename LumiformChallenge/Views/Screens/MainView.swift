//
//  MainView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = PageViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.page.isEmpty {
                    UnavailableDataView {
                        loadData()
                    }
                } else {
                    List(viewModel.page.where { $0.isRootPage }) { pageItem in
                        HierarchicalListView(rootItem: pageItem.item)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Content Browser")
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK") { viewModel.removeError() }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown Error")
            }
            .task { loadData() }
            .refreshable { loadData() }
        }
    }
    
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
}

struct HierarchicalListView: View {
    let rootItem: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ContentItemView(item: rootItem)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainView()
}
