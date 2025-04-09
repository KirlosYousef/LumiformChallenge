//
//  RealmItem.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 05/04/2025.
//

import Foundation
import RealmSwift

class RealmItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var type: String
    @Persisted var title: String?
    @Persisted var items: List<RealmItem>
    @Persisted var imageURL: String?
    @Persisted var depthLevel: Int
    @Persisted var isRootPage: Bool = false
    @Persisted var repeated: Bool?
    
    convenience init(item: Item, isRootPage: Bool = false) {    
        self.init()
        self.type = item.type.rawValue
        self.title = item.title
        self.imageURL = item.imageURL
        self.depthLevel = item.depthLevel
        self.isRootPage = isRootPage
        self.repeated = item.repeated
        
        // List initialization
        let children = List<RealmItem>()
        item.items?.forEach { child in
            let realmChild = RealmItem(item: child)
            if !children.contains(where: { $0.id == realmChild.id }) {
                children.append(realmChild)
            }
        }
        self.items = children
    }
    
    var item: Item {
        Item(
            id: UUID(uuidString: id.stringValue) ?? UUID(),
            type: ItemType(rawValue: type) ?? .page,
            title: title,
            items: items.map { $0.item },
            imageURL: imageURL,
            depthLevel: depthLevel,
            repeated: repeated
        )
    }
}
