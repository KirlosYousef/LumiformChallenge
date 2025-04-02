//
//  NetworkError.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case decodingFailed
    case serverError(code: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid endpoint URL"
        case .decodingFailed: return "Failed to parse response"
        case .serverError(let code): return "Server error (\(code))"
        }
    }
}
