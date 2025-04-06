//
//  ImageDetailView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI
import SDWebImageSwiftUI

/// Full screen image preview with pinch-to-zoom
struct ImageDetailView: View {
    let url: URL
    let title: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            WebImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .imageZoomFunctionality
                case .failure:
                    Image(systemName: "photo.badge.exclamationmark.fill")
                        .frame(width: 150, height: 150)
                @unknown default:
                    EmptyView()
                }
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.title2)
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    if let url = MockPage.validImage.getImageURL() {
        ImageDetailView(url: url, title: "Sample Image")
            .padding()
    } else {
        Text("Invalid URL")
    }
}
