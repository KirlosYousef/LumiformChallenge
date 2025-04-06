//
//  TestHelper.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// Helper functions and extensions for UI testing
enum TestHelper {
    /// Standard timeout for element existence checks
    static let standardTimeout: TimeInterval = 5.0
    
    /// Longer timeout for network operations
    static let networkTimeout: TimeInterval = 10.0
    
    /// Wait for an element to exist, with a specified timeout
    /// - Parameters:
    ///   - element: The element to wait for
    ///   - timeout: The maximum time to wait
    ///   - file: The file from which this method is called
    ///   - line: The line number from which this method is called
    /// - Returns: Whether the element appeared within the timeout
    @discardableResult
    static func waitForElementToExist(
        _ element: XCUIElement,
        timeout: TimeInterval = standardTimeout,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: element
        )
        
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result != .completed {
            XCTFail("Failed waiting for \(element) to exist", file: file, line: line)
            return false
        }
        return true
    }
    
    /// Wait for an element to be hittable
    /// - Parameters:
    ///   - element: The element to wait for
    ///   - timeout: The maximum time to wait
    ///   - file: The file from which this method is called
    ///   - line: The line number from which this method is called
    /// - Returns: Whether the element became hittable within the timeout
    @discardableResult
    static func waitForElementToBeHittable(
        _ element: XCUIElement,
        timeout: TimeInterval = standardTimeout,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isHittable == true"),
            object: element
        )
        
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result != .completed {
            XCTFail("Failed waiting for \(element) to be hittable", file: file, line: line)
            return false
        }
        return true
    }
    
    /// Wait for an element to disappear
    /// - Parameters:
    ///   - element: The element to wait for disappearance
    ///   - timeout: The maximum time to wait
    ///   - file: The file from which this method is called
    ///   - line: The line number from which this method is called
    /// - Returns: Whether the element disappeared within the timeout
    @discardableResult
    static func waitForElementToDisappear(
        _ element: XCUIElement,
        timeout: TimeInterval = standardTimeout,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: element
        )
        
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result != .completed {
            XCTFail("Failed waiting for \(element) to disappear", file: file, line: line)
            return false
        }
        return true
    }
    
    /// Take a screenshot and add it as an attachment
    /// - Parameters:
    ///   - app: The application instance
    ///   - name: The name of the screenshot
    ///   - lifetime: The lifetime of the attachment
    static func takeScreenshot(
        of app: XCUIApplication,
        name: String,
        lifetime: XCTAttachment.Lifetime = .deleteOnSuccess
    ) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = lifetime
        XCTContext.runActivity(named: "Taking screenshot: \(name)") { activity in
            activity.add(attachment)
        }
    }
}