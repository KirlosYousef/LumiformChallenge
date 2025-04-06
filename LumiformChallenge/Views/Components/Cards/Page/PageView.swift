//
//  PageView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct PageView: View {
    let item: Item
    
    var body: some View {
        PageHeaderView(title: item.title ?? "Untitled Page")
        
        
        ForEach(Array((item.items ?? []).enumerated()), id: \.1.id) { index, child in
            ContentItemView(item: child)
        }
    }
}
