//
//  ImageCell.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct ImageCell: View {
    let url: URL
    let title: String
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 300, height: 200)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .frame(maxWidth: 300)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3)) {
                                isExpanded.toggle()
                            }
                        }
                case .failure:
                    Image(systemName: "photo.badge.exclamationmark.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .frame(width: 300, height: 200)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            
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
    if let url = URL(string: "https://robohash.org/100?&set=set4&size=400x400") {
        ImageCell(url: url, title: "Sample Image")
            .padding()
    } else {
        Text("Invalid URL")
    }
}
