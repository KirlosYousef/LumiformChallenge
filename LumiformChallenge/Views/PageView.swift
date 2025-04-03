//
//  PageView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import SwiftUI

struct PageView: View {
    @StateObject private var viewModel = PageViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert("Error", isPresented: $viewModel.hasError) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "Unknown Error")
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    PageView()
}
