//
//  LoadingView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Color.gray.opacity(0.4)
            .ignoresSafeArea()
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .scaleEffect(1.5)
    }
}

#Preview {
    LoadingView()
}
