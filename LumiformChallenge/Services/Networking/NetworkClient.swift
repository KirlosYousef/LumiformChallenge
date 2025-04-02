//
//  NetworkClient.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

protocol NetworkClient {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkClient {} // Conform URLSession to protocol
