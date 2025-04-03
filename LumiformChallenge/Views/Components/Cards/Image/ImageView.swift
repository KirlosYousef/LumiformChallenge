//
//  ImageView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct ImageView: View {
    let item: Item
    let isLast: Bool
    
    var body: some View {
        if let imageURL = item.getImageURL() {
            ImageCell(url: imageURL, title: item.title ?? "Image")
                .padding(.vertical, 8)
        } else {
            TextViewCell(text: "Missing image: \(item.title ?? "Untitled")", depth: item.depthLevel, isLast: isLast)
        }
    }
}
