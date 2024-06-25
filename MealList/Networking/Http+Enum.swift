//
//  Http+Enum.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, patch, delete
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case cacheControl = "Cache-Control"
}

enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
}

struct HTTPHeader {
    let field: HTTPHeaderField
    let value: HTTPHeaderValue
}
