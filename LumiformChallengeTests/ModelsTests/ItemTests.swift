//
//  ItemTests.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import Testing
import Foundation
@testable import LumiformChallenge

@Suite("Item model tests") struct ItemTests {
    var mockPage = MockPage.valid.withDepthLevels()
    
    @Test("Test root item level") func rootDepth() {
        #expect(mockPage.depthLevel == 0)
    }
    
    @Test("Test nested items level") func nestedDepths() {
        #expect(mockPage.depthLevel == 0)
        #expect(mockPage.items?[0].depthLevel == 1)
        #expect(mockPage.items?[0].items?[0].depthLevel == 2)
    }
    
    @Test("Test same item levels") mutating func sameDepths() {
        mockPage.items?.append(MockPage.validSection)
        mockPage = mockPage.withDepthLevels() // Recalculate after modification
        
        let firstChildDepth = mockPage.items?[0].depthLevel
        let secondChildDepth = mockPage.items?[1].depthLevel
        
        #expect(firstChildDepth == 1)
        #expect(secondChildDepth == 1)
    }
}
