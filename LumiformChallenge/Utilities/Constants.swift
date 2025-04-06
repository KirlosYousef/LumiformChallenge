//
//  Constants.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

/// App-wide constants
enum Constants {
    /// API related constants
    enum API {
        /// URL to fetch the page content from the server
        static var pageURL: URL { AppEnvironment.api.pageURL }
    }
    
    /// UI related constants
    enum UI {
        static let standardAnimationDuration: Double = 0.3
        static let standardCornerRadius: CGFloat = 8
        static let standardSmallSpacing: CGFloat = 4
        static let standardlargeSpacing: CGFloat = 8
    }
}
