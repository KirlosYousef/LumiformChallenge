//
//  AppConfiguration.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//


import XCTest

/// Helper for configuring the app for UI testing
enum AppConfiguration {
    /// Configure the app with specific test settings
    /// - Parameters:
    ///   - app: The XCUIApplication instance
    ///   - useMockData: Whether to use mock data
    ///   - forceLoadingState: Whether to force the loading state
    ///   - forceEmptyState: Whether to force the empty state
    ///   - forceErrorState: Whether to force the error state
    static func configureApp(
        _ app: XCUIApplication,
        useMockData: Bool = true,
        forceLoadingState: Bool = false,
        forceEmptyState: Bool = false,
        forceErrorState: Bool = false
    ) {
        var launchArguments: [String] = []
        
        launchArguments.append(LaunchArguments.isUITesting)
        
        if useMockData {
            launchArguments.append(LaunchArguments.useMockData)
        }
        
        if forceLoadingState {
            launchArguments.append(LaunchArguments.forceLoadingState)
        }
        
        if forceEmptyState {
            launchArguments.append(LaunchArguments.forceEmptyState)
        }
        
        if forceErrorState {
            launchArguments.append(LaunchArguments.forceErrorState)
        }
        
        app.launchArguments = launchArguments
    }
}
