//
//  LumiformChallengeUITests.swift
//  LumiformChallengeUITests
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import XCTest

/// Main UI test class that performs accessibility and basic launch tests
final class LumiformChallengeUITests: BaseUITest {

    /// Setup for each test
    override func setUpWithError() throws {
        // Call the base class setup
        try super.setUpWithError()
    }

    /// Teardown for each test
    override func tearDownWithError() throws {
        // Call the base class teardown
        try super.tearDownWithError()
    }

    /// Test app launch and basic UI elements
    func testBasicUIElements() throws {
        // Launch the app
        launchApp()
        
        // Verify navigation title exists
        XCTAssertTrue(mainScreen.navigationTitle.exists)
        
        // Wait for content to load
        mainScreen.waitForContentToLoad()
        
        // Take a screenshot
        TestHelper.takeScreenshot(of: app, name: "BasicUIElements")
    }
    
    /// Test accessibility of the main components
    func testAccessibility() throws {
        // Launch the app
        launchApp()
        
        // Wait for content to load
        mainScreen.waitForScreenToLoad().waitForContentToLoad()
        
        // Verify navigation title is accessible
        XCTAssertTrue(mainScreen.navigationTitle.isEnabled)
        
        // Test content list accessibility
        if mainScreen.contentList.exists {
            XCTAssertTrue(mainScreen.contentList.isEnabled)
        }
        
        // Test the retry button accessibility if it exists
        if mainScreen.retryButton.exists {
            XCTAssertTrue(mainScreen.retryButton.isEnabled)
        }
        
        // Take a screenshot
        TestHelper.takeScreenshot(of: app, name: "AccessibilityTest")
    }

    /// Test application launch performance
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
