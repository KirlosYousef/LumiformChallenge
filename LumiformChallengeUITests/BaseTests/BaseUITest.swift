//
//  BaseUITest.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// Base class for UI tests
class BaseUITest: XCTestCase {
    // MARK: - Properties
    
    /// The application instance
    let app = XCUIApplication()
    
    /// Main screen page object
    lazy var mainScreen = MainScreen(app: app)
    
    /// Content list screen page object
    lazy var contentListScreen = ContentListScreen(app: app)
    
    // MARK: - Setup and Teardown
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // Force portrait orientation for UI tests
        XCUIDevice.shared.orientation = .portrait
        
        // Default configuration uses mock data
        AppConfiguration.configureApp(app, useMockData: true)
    }
    
    override func tearDownWithError() throws {
        // Take a final screenshot if the test fails
        if testRun?.hasSucceeded == false {
            TestHelper.takeScreenshot(of: app, name: "Failure-\(name)", lifetime: .keepAlways)
        }
    }
    
    // MARK: - Helper Methods
    
    /// Launches the app with specific configuration
    /// - Parameters:
    ///   - useMockData: Whether to use mock data
    ///   - forceLoadingState: Whether to force the loading state
    ///   - forceEmptyState: Whether to force the empty state
    ///   - forceErrorState: Whether to force the error state
    func launchApp(
        useMockData: Bool = true,
        forceLoadingState: Bool = false,
        forceEmptyState: Bool = false,
        forceErrorState: Bool = false
    ) {
        AppConfiguration.configureApp(
            app,
            useMockData: useMockData,
            forceLoadingState: forceLoadingState,
            forceEmptyState: forceEmptyState,
            forceErrorState: forceErrorState
        )
        app.launch()
    }
}
