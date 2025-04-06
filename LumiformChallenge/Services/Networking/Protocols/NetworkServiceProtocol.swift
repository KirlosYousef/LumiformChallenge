//
//  NetworkServiceProtocol.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 06/04/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    /// Fetches the form page from the API
    func fetchPage() async throws -> Item
}
