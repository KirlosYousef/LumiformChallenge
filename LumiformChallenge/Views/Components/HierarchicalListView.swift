//
//  HierarchicalListView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import SwiftUI

/// Displays a hierarchy of content items starting from a root item
struct HierarchicalListView: View {
    /// The root item to display and its children
    let rootItem: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.UI.standardlargeSpacing) {
                ContentItemView(item: rootItem)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let item = MockPage.valid
    return HierarchicalListView(rootItem: item)
}
