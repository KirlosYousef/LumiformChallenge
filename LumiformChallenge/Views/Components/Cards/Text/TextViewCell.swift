//
//  TextViewCell.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct TextViewCell: View {
    let text: String
    let depth: Int
    let isLast: Bool
    
    var body: some View {
        Text(text)
            .hierarchyFont(itemType: .text)
            .padding(.vertical, 8)
            .padding(.horizontal, 2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TextViewCell(text: "This is a sample text item", depth: 2, isLast: true)
        .padding()
}
