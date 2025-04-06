//
//  MainScreen.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// Page object representing the main content browser screen
class MainScreen {
    // MARK: - Properties
    
    /// The app instance
    private let app: XCUIApplication
    
    // MARK: - Elements
    
    /// Navigation title element
    var navigationTitle: XCUIElement {
        app.navigationBars["Content Browser"]
    }
    
    /// Loading indicator
    var loadingIndicator: XCUIElement {
        app.activityIndicators.firstMatch
    }
    
    /// Content list element
    var contentList: XCUIElement {
        app.collectionViews.firstMatch
    }
    
    /// Empty state view
    var emptyStateView: XCUIElement {
        app.staticTexts["No Content"]
    }
    
    /// Retry button in empty state view
    var retryButton: XCUIElement {
        app.buttons["Retry"]
    }
    
    /// Error alert if present
    var errorAlert: XCUIElement {
        app.alerts["Error"]
    }
    
    /// OK button in error alert
    var errorAlertOkButton: XCUIElement {
        app.alerts["Error"].buttons["OK"]
    }
    
    // MARK: - Initialization
    
    /// Initialize with the app instance
    /// - Parameter app: The XCUIApplication instance
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - Actions
    
    /// Wait for the screen to load
    /// - Returns: Self for method chaining
    @discardableResult
    func waitForScreenToLoad() -> Self {
        XCTAssertTrue(TestHelper.waitForElementToExist(navigationTitle))
        return self
    }
    
    /// Pull to refresh the content
    /// - Returns: Self for method chaining
    @discardableResult
    func pullToRefresh() -> Self {
        contentList.swipeDown()
        return self
    }
    
    /// Wait for content to load
    /// - Returns: Self for method chaining
    @discardableResult
    func waitForContentToLoad() -> Self {
        // First wait for the loading indicator to appear
        if loadingIndicator.exists {
            TestHelper.waitForElementToDisappear(loadingIndicator, timeout: TestHelper.networkTimeout)
        }
        return self
    }
    
    /// Tap the retry button if present
    /// - Returns: Self for method chaining
    @discardableResult
    func tapRetryIfNeeded() -> Self {
        if emptyStateView.exists && retryButton.exists {
            TestHelper.waitForElementToBeHittable(retryButton)
            retryButton.tap()
        }
        return self
    }
    
    /// Dismiss error alert if present
    /// - Returns: Self for method chaining
    @discardableResult
    func dismissErrorAlertIfPresent() -> Self {
        if errorAlert.exists {
            TestHelper.waitForElementToBeHittable(errorAlertOkButton)
            errorAlertOkButton.tap()
        }
        return self
    }
    
    /// Assert that content is displayed
    /// - Returns: Self for method chaining
    @discardableResult
    func assertContentIsDisplayed() -> Self {
        XCTAssertTrue(contentList.exists)
        XCTAssertFalse(emptyStateView.exists)
        return self
    }
    
    /// Assert that empty state is displayed
    /// - Returns: Self for method chaining
    @discardableResult
    func assertEmptyStateIsDisplayed() -> Self {
        XCTAssertTrue(emptyStateView.exists)
        XCTAssertTrue(retryButton.exists)
        return self
    }
}
