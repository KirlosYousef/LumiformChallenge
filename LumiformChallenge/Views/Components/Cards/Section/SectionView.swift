//
//  SectionView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct SectionView: View {
    let item: Item
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.standardSmallSpacing) {
            CollapseButton(isExpanded: $isExpanded, item: item)
            
            if isExpanded {
                ForEach(Array((item.items ?? []).enumerated()), id: \.1.id) { index, child in
                    ContentItemView(item: child)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
                }
                .padding(.leading, 4)
            }
        }
        .cardStyle
    }
}

struct CollapseButton: View {
    @Binding var isExpanded: Bool
    var item: Item
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: Constants.UI.standardAnimationDuration)) {
                isExpanded.toggle()
            }
        }) {
            HStack {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(width: 24)
                
                Text(item.title ?? "Untitled Section")
                    .hierarchyFont(itemType: .section,
                                   depthLevel: item.depthLevel)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    let section = MockPage.validSection
    
    return SectionView(item: section)
        .padding()
})
