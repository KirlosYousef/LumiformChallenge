//
//  NetworkClientProtocol.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation

protocol NetworkClientProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkClientProtocol {} // Conform URLSession to protocol
