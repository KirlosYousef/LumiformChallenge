//
//  LaunchArguments.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import Foundation

/// Launch arguments to control app behavior in tests
enum LaunchArguments {
    /// Declares if UITesting is running
    static let isUITesting = "-isUITesting"
    
    /// Use mock data instead of network
    static let useMockData = "-useMockData"
    
    /// Force loading state for UI testing
    static let forceLoadingState = "-forceLoadingState"
    
    /// Force empty state for UI testing
    static let forceEmptyState = "-forceEmptyState"
    
    /// Force error state for UI testing
    static let forceErrorState = "-forceErrorState"
}
