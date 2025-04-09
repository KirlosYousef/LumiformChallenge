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
        for item in (items ?? []){
            repeatedItems.append(item)
        }
    }
}
