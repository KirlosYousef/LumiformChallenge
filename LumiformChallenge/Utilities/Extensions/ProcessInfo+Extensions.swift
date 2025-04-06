//
//  ProcessInfo+Extensions.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import Foundation

/// Used to recognized that UITestings are running and modify the app behavior accordingly
extension ProcessInfo {
    var isUITesting: Bool {
        return arguments.contains(LaunchArguments.useMockData)
    }
    
    var useMockData: Bool {
        return arguments.contains(LaunchArguments.useMockData)
    }
    
    var forceEmptyState: Bool {
        return arguments.contains(LaunchArguments.forceEmptyState)
    }
    
    var forceErrorState: Bool {
        return arguments.contains(LaunchArguments.forceErrorState)
    }
    
    var forceLoadingState: Bool {
        return arguments.contains(LaunchArguments.forceLoadingState)
    }
}
