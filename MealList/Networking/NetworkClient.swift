//
//  NetworkClient.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

final class NetworkClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func call(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
