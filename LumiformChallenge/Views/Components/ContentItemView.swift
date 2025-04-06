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
    
    var body: some View {
        switch item.type {
        case .page:
            PageView(item: item)
        case .section:
            SectionView(item: item)
        case .text:
            TextViewCell(text: item.title ?? "No text",
                         depth: item.depthLevel)
        case .image:
            ImageView(item: item)
        }
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading) {
            ContentItemView(item: MockPage.valid)
        }
        .padding()
    }
} 
