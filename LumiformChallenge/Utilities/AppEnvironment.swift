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
                baseURL = URL(string: "https://mocki.io/v1")!
                pageEndpoint = "6c823976-465e-401e-ae8d-d657d278e98e" // Should be aligned with the environment
            }
        }
    }
    
    /// Shared API configuration instance
    static let api = API()
}
