//
//  APIRequest.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct APIRequest {
    let path: String
    var method: HTTPMethod = .get
    var headers: [HTTPHeader]?
    var queries: [String: String]?
    var parameters: [String: Any]?
}

extension APIRequest {
    func toURLRequest(_ baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        if method == .get, let queries {
            urlComponents.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        urlComponents.path = "\(urlComponents.path)\(path)"
        
        guard let apiURL = urlComponents.url else {
            return nil
        }
        
        print("API URL:", apiURL)
        
        var urlRequest = URLRequest(url: apiURL)
        
        urlRequest.httpMethod = method.rawValue
        
        if let headers {
            headers.forEach {
                urlRequest.addValue($0.value.rawValue, forHTTPHeaderField: $0.field.rawValue)
            }
        }

        if method == .post, let parameters {
            urlRequest.httpBody = httpBodyData(from: parameters)
        }
        
        return urlRequest
    }
    
    private func httpBodyData(from params: [String: Any]) -> Data? {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }

        return httpBody
    }
}
