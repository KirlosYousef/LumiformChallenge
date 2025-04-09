//
//  SectionViewModel.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 09/04/2025.
//

import Foundation

class SectionViewModel: ObservableObject {
    @Published var repeatedItems: [Item] = []
    
    func addRepeatedItems(items: [Item]?) {
        if let items {
            repeatedItems.append(contentsOf: items)
        }
    }
}
