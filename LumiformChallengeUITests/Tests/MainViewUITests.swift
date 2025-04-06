//
//  MainViewUITests.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// UI tests for the main view
final class MainViewUITests: BaseUITest {
    
    /// Test that the app loads and displays content successfully
    func testContentLoadsSuccessfully() throws {
        launchApp(useMockData: true)
        
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
            .assertContentIsDisplayed()
        
        // Take a screenshot of the successful content load
        TestHelper.takeScreenshot(of: app, name: "ContentLoadedSuccessfully")
    }
    
    /// Test pull-to-refresh functionality
    func testPullToRefresh() throws {
        launchApp(useMockData: true)
        
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
            .pullToRefresh()
            .waitForContentToLoad()
            .assertContentIsDisplayed()
        
        TestHelper.takeScreenshot(of: app, name: "PullToRefreshCompleted")
    }
    
    /// Test empty state view appears correctly
    func testEmptyStateView() throws {
        // Launch with empty state forced
        launchApp(useMockData: true, forceEmptyState: true)
        
        mainScreen
            .waitForScreenToLoad()
            .waitForContentToLoad()
            .assertEmptyStateIsDisplayed()
        
        TestHelper.takeScreenshot(of: app, name: "EmptyStateDisplayed")
        
        // Test the retry button
        mainScreen
            .tapRetryIfNeeded()
            .waitForContentToLoad()
    }
    
    /// Test error handling
    func testErrorHandling() throws {
        // Launch with error state forced
        launchApp(useMockData: true, forceErrorState: true)
        
        // Wait for the error alert to appear
        XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: TestHelper.standardTimeout))
        
        TestHelper.takeScreenshot(of: app, name: "ErrorAlertDisplayed")
        
        // Dismiss the error alert
        mainScreen.dismissErrorAlertIfPresent()
    }
    
    /// Test loading state
    func testLoadingState() throws {
        // Launch with loading state forced
        launchApp(useMockData: true, forceLoadingState: true)
        
        mainScreen.waitForScreenToLoad()
        
        // Verify loading indicator is visible
        XCTAssertTrue(mainScreen.loadingIndicator.exists)
        
        TestHelper.takeScreenshot(of: app, name: "LoadingStateDisplayed")
    }
}