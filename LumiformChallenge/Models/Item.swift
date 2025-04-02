//
//  Item.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

enum ItemType: String, Codable {
    case page, section, text, image
}

struct Item: Codable, Identifiable {
    var id = UUID()
    let type: ItemType
    let title: String?
    let items: [Item]?  // For sections and questions
    let imageURL: String?    // Image URL (if `type` is `image`)
    
    enum CodingKeys: String, CodingKey {
        case type, title, items,
             imageURL = "src"
    }
}
