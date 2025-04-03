//
//  TestPageData.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

enum MockPage {
    static let valid = Item(
        type: .page,
        title: "Mock Page",
        items: [
            Item(
                type: .section,
                title: "Mock Section",
                items: [
                    Item(
                        type: .text,
                        title: "Sample Text Question",
                        items: nil,
                        imageURL: nil
                    ),
                    Item(
                        type: .image,
                        title: "Sample Image",
                        items: nil,
                        imageURL: "https://robohash.org/100?&set=set4&size=400x400"
                    )
                ],
                imageURL: nil
            )
        ],
        imageURL: nil
    )
    
    static let validSection = Item(
        type: .section,
        title: "Mock Section",
        items: [
            Item(
                type: .text,
                title: "Sample Text Question",
                items: nil,
                imageURL: nil
            ),
            Item(
                type: .image,
                title: "Sample Image",
                items: nil,
                imageURL: "https://robohash.org/100?&set=set4&size=400x400"
            )
        ],
        imageURL: nil
    )
    
    static let invalidTitle = Item(
        type: .page,
        title: nil, // Invalid
        items: nil,
        imageURL: nil
    )
}
