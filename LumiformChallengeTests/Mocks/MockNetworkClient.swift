//
//  MockNetworkClient.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 02/04/2025.
//

import Foundation
@testable import LumiformChallenge

struct MockNetworkClient: NetworkClient {
    let data: Data
    let statusCode: Int
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        return (data, response)
    }
}
