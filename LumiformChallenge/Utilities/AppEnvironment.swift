//
//  AppEnvironment.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import Foundation

/// Environment-specific configuration management
enum AppEnvironment {
    enum ConfigType {
        case development
        case staging
        case production
        
        /// Current active environment
        static var current: ConfigType {
#if DEBUG
            return .development
#else
            return .production
#endif
        }
    }
    
    /// API configuration based on environment
    struct API {
        let baseURL: URL
        let pageEndpoint: String
        
        var pageURL: URL {
            baseURL.appendingPathComponent(pageEndpoint)
        }
        
        /// Initialize with environment-specific values
        init(for environment: ConfigType = ConfigType.current) {
            switch environment {
            case .development,
                    .staging,
                    .production:
                baseURL = URL(string: "https://run.mocky.io/v3")!
                pageEndpoint = "dfbca98f-8356-4b44-8e37-d12ef918e123" // Should be aligned with the environment
            }
        }
    }
    
    /// Shared API configuration instance
    static let api = API()
}
