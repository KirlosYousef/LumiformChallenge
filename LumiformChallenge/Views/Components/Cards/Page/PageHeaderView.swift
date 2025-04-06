//
//  PageHeaderView.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import SwiftUI

struct PageHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.standardlargeSpacing) {
            Text(title)
                .hierarchyFont(itemType: .page)
                .padding(.vertical, 12)
                .padding(.horizontal, 2)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PageHeaderView(title: "Main Page Title")
        .padding()
} 
