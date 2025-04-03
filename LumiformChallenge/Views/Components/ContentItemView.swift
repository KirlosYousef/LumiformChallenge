//
//  ContentItemView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

/// Displays appropriate view based on the content item type
struct ContentItemView: View {
    let item: Item
    let isLast: Bool
    
    var body: some View {
        switch item.type {
        case .page:
            PageView(item: item)
        case .section:
            SectionView(item: item, isLast: isLast)
        case .text:
            TextViewCell(text: item.title ?? "No text", depth: item.depthLevel, isLast: isLast)
        case .image:
            ImageView(item: item, isLast: isLast)
        }
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading) {
            ContentItemView(
                item: MockPage.valid,
                isLast: true
            )
        }
        .padding()
    }
} 
