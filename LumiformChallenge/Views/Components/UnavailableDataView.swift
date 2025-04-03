//
//  UnavailableDataView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct UnavailableDataView: View {
    var onRetry: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("No Content", systemImage: "doc.text.magnifyingglass")
        } description: {
            Text("Content could not be loaded")
        } actions: {
            Button("Retry") {
                onRetry()
            }
            .buttonStyle(.bordered)
        }
    }
}
