//
//  APIClient.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

final class APIClient {
    private let baseURLString: String
    private let networkClient: NetworkClient
    private let jsonDecoder: JSONDecoder
    
    init(
        with baseURLString: String = NetworkConstants.baseUrl,
        networkClient: NetworkClient = NetworkClient(),
        jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.baseURLString = baseURLString
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    func call<ResponseType: Decodable>(_ request: APIRequest) async throws -> ResponseType {
        let responseData = try await sendRequest(request)
        return try decode(responseData)
    }
    
    private func sendRequest(_ request: APIRequest) async throws -> Data {
        guard let urlRequest = request.toURLRequest(baseURLString) else {
            throw APIError.invalidRequest
        }
        
        do {
            let (data, urlResponse) = try await networkClient.call(urlRequest)
            try validateResponse(urlResponse)
            return data
        } catch {
            throw APIError.network(error)
        }
    }
    
    private func decode<T:Decodable>(_ data: Data) throws -> T {
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw APIError.decode(error)
        }
    }
    
    private func validateResponse(_ urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw APIError.invalidHTTPResponse
        }
        
        guard !(200..<300).contains(httpResponse.statusCode) else {
            return
        }
        
        throw APIError.errorStatus(httpResponse.statusCode)
    }
}
