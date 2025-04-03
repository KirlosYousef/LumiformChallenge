//
//  ViewModifiers.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

// MARK: - HierarchyFont
struct HierarchyFont: ViewModifier {
    let itemType: ItemType
    let depthLevel: Int
    
    func body(content: Content) -> some View {
        Group {
            switch itemType {
            case .page:
                content
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
            case .section:
                // Font size decreases with depth level
                let fontSize = max(22 - CGFloat(2 * depthLevel), 18)
                content
                    .font(.system(size: fontSize, weight: .medium, design: .rounded))
            case .text:
                content
                    .font(.system(size: 17, weight: .regular, design: .rounded))
            case .image:
                content
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(.secondaryLabel))
            }
        }
    }
}

// MARK: - AnimatedCardStyle
struct AnimatedCardStyle: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground))//colorScheme == .dark ? Color(white: 0.2) : Color.white)
                    .strokeBorder(Color(.label).opacity(0.1), lineWidth: 0.5)
            }
            .animation(.spring(response: 0.3), value: UUID())
    }
}

// MARK: - View Extensions
extension View {
    func hierarchyFont(itemType: ItemType, depthLevel: Int = 0) -> some View {
        modifier(HierarchyFont(itemType: itemType, depthLevel: depthLevel))
    }
    
    func animatedCardStyle() -> some View {
        modifier(AnimatedCardStyle())
    }
} 
