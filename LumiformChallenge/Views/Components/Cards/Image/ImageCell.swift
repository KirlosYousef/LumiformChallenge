//
//  ImageCell.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageCell: View {
    let url: URL
    let title: String
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .center, spacing: Constants.UI.standardSmallSpacing) {
            WebImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .onTapGesture {
                            withAnimation(.spring(response: Constants.UI.standardAnimationDuration)) {
                                isExpanded.toggle()
                            }
                        }
                case .failure:
                    Image(systemName: "photo.badge.exclamationmark.fill")
                        .font(.largeTitle)
                @unknown default:
                    EmptyView()
                }
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
            .frame(maxWidth: 300)
            .background(Color.gray.opacity(0.1))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: Constants.UI.standardCornerRadius))
            .transition(.fade(duration: 1))
            
            Text(title)
                .lineLimit(1)
                .hierarchyFont(itemType: .image)
        }
        .fullScreenCover(isPresented: $isExpanded, content: {
            ImageDetailView(url: url, title: title)
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    if let url = MockPage.validImage.getImageURL() {
        ImageCell(url: url, title: "Sample Image")
            .padding()
    } else {
        Text("Invalid URL")
    }
}
