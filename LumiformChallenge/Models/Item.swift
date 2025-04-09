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
    var type: ItemType
    var title: String?
    var items: [Item]?
    var imageURL: String?
    var depthLevel: Int = 0
    var repeated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type, title, items, repeated
        case imageURL = "src"
    }
    
    func getImageURL() -> URL? {
        guard type == .image, let urlString = imageURL else { return nil }
        return URL(string: urlString)
    }
}

// MARK: Depth Levels
extension Item {
    /// Returns the Item with depth levels
    func withDepthLevels() -> Item {
        var copy = self
        copy.updateDepthLevels()
        return copy
    }
    
    /// Recursively updates depth levels starting from a parent depth
    /// Call with parentDepth: -1 for root items
    mutating func updateDepthLevels(parentDepth: Int = -1) {
        // Set current item's depth
        self.depthLevel = parentDepth + 1
        
        // Recursively update children items with current depth
        items?.enumerated().forEach { ind, item in
            if item.type == .page {
                // Pages are always at first level
                items?[ind].updateDepthLevels(parentDepth: -1)
            } else {
                items?[ind].updateDepthLevels(parentDepth: self.depthLevel)
            }
        }
    }
}
