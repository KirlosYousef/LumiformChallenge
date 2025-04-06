//
//  ContentListView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import SwiftUI
import RealmSwift

/// Displays a list of page items
struct ContentListView: View {
    /// The collection of RealmItems to display
    let pageItems: Results<RealmItem>
    
    var body: some View {
        List(pageItems.where { $0.isRootPage }) { pageItem in
            HierarchicalListView(rootItem: pageItem.item)
        }
        .listStyle(.plain)
    }
}
