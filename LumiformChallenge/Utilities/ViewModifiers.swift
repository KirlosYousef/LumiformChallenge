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
                    .fontDesign(.rounded)
            case .image:
                content
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(.secondaryLabel))
            }
        }
    }
}

// MARK: - AnimatedCardStyle
struct CardStyle: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemBackground))
                    .strokeBorder(Color(.label).opacity(0.1), lineWidth: 0.5)
            }
            .animation(.spring(response: 0.3), value: UUID())
    }
}

// MARK: - ImageZoomGesture
struct PinchToZoomGesture: ViewModifier {
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .offset(offset)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        withAnimation {
                            let delta = value / lastScale
                            lastScale = value
                            scale = min(max(scale * delta, 1), 5)
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            lastScale = 1.0
                        }
                    }
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                    }
                    .onEnded { _ in
                        lastOffset = offset
                        
                        // Reset if scale is back to normal
                        if scale <= 1.01 {
                            withAnimation(.spring()) {
                                offset = .zero
                                lastOffset = .zero
                            }
                        }
                    }
            )
            .onTapGesture(count: 2) {
                withAnimation(.spring()) {
                    if scale > 1 {
                        scale = 1.0
                        offset = .zero
                        lastOffset = .zero
                    } else {
                        scale = 2.0
                    }
                }
            }
    }
}

// MARK: - View Extensions
extension View {
    /// Sets the text font according to the hierarchy and its depthLevel
    func hierarchyFont(itemType: ItemType, depthLevel: Int = 0) -> some View {
        modifier(HierarchyFont(itemType: itemType, depthLevel: depthLevel))
    }
    
    /// Sets the style on item cards
    var cardStyle: some View {
        modifier(CardStyle())
    }
    
    /// Enables pinch-to-zoom functionality on images
    var imageZoomFunctionality: some View {
        modifier(PinchToZoomGesture())
    }
}
