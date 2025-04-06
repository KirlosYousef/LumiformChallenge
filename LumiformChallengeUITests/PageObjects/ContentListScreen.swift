//
//  ContentListScreen.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// Page object representing the content list screen
class ContentListScreen {
    // MARK: - Properties
    
    /// The app instance
    private let app: XCUIApplication
    
    // MARK: - Elements
    
    /// Content cells
    var contentCells: XCUIElementQuery {
        app.cells
    }
    
    /// First content cell
    var firstContentCell: XCUIElement {
        contentCells.element(boundBy: 0)
    }
    
    /// All text elements in content
    var contentTexts: XCUIElementQuery {
        app.staticTexts
    }
    
    /// All images in content
    var contentImages: XCUIElementQuery {
        app.images
    }
    
    // MARK: - Initialization
    
    /// Initialize with the app instance
    /// - Parameter app: The XCUIApplication instance
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - Actions
    
    /// Wait for content cells to load
    /// - Returns: Self for method chaining
    @discardableResult
    func waitForContentToLoad() -> Self {
        XCTAssertTrue(TestHelper.waitForElementToExist(firstContentCell, timeout: TestHelper.networkTimeout))
        return self
    }
    
    /// Tap on a content cell at the specified index
    /// - Parameter index: The index of the cell to tap
    /// - Returns: Self for method chaining
    @discardableResult
    func tapContentCell(at index: Int) -> Self {
        guard contentCells.count > index else {
            XCTFail("Trying to tap cell at index \(index) but there are only \(contentCells.count) cells")
            return self
        }
        
        let cell = contentCells.element(boundBy: index)
        TestHelper.waitForElementToBeHittable(cell)
        cell.tap()
        return self
    }
    
    /// Tap the first content cell
    /// - Returns: Self for method chaining
    @discardableResult
    func tapFirstContentCell() -> Self {
        return tapContentCell(at: 0)
    }
    
    /// Swipe up to scroll down the content
    /// - Returns: Self for method chaining
    @discardableResult
    func scrollDown() -> Self {
        firstContentCell.swipeUp()
        return self
    }
    
    /// Swipe down to scroll up the content
    /// - Returns: Self for method chaining
    @discardableResult
    func scrollUp() -> Self {
        firstContentCell.swipeDown()
        return self
    }
    
    /// Assert that a specific text exists in the content
    /// - Parameter text: The text to search for
    /// - Returns: Self for method chaining
    @discardableResult
    func assertContainsText(_ text: String) -> Self {
        let textElement = contentTexts[text]
        XCTAssertTrue(TestHelper.waitForElementToExist(textElement))
        return self
    }
    
    /// Assert that content has loaded with at least one cell
    /// - Returns: Self for method chaining
    @discardableResult
    func assertContentHasLoaded() -> Self {
        XCTAssertTrue(contentCells.count > 0, "Content should have at least one cell")
        return self
    }
}