//
//  ContentListUITests.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// UI tests for the content list
final class ContentListUITests: BaseUITest {
    
    /// Test content navigation and interactions
    func testContentInteraction() throws {
        launchApp(useMockData: true)
        
        // Wait for the main screen to load
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
        
        // Verify content has loaded properly
        contentListScreen
            .waitForContentToLoad()
            .assertContentHasLoaded()
        
        // Test scrolling
        contentListScreen
            .scrollDown()
            .scrollUp()
        
        TestHelper.takeScreenshot(of: app, name: "ContentInteraction")
    }
    
    /// Test content display and specific elements
    func testContentDisplay() throws {
        launchApp(useMockData: true)
        
        // Wait for the main screen to load
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
        
        // Verify content has loaded properly
        contentListScreen
            .waitForContentToLoad()
            .assertContentHasLoaded()
        
        // Check for existence of different content types
        XCTAssertGreaterThan(contentListScreen.contentTexts.count, 0, "There should be text elements")
        
        TestHelper.takeScreenshot(of: app, name: "ContentDisplay")
    }
    
    /// Test tapping on content items
    func testContentItemTap() throws {
        launchApp(useMockData: true)
        
        // Wait for the main screen to load
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
        
        // Verify content has loaded properly
        contentListScreen.waitForContentToLoad()
        
        // Make sure we have content cells to tap
        guard contentListScreen.contentCells.count > 0 else {
            XCTFail("No content cells available to tap")
            return
        }
        
        // Tap the first content cell
        contentListScreen.tapFirstContentCell()
        
        TestHelper.takeScreenshot(of: app, name: "ContentItemTapped")
    }
}
