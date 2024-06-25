//
//  APIError.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

enum APIError: Error {
    case invalidRequest
    case network(Error)
    case decode(Error)
    case invalidHTTPResponse
    case errorStatus(Int)
}
