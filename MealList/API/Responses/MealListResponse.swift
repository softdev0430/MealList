//
//  MealListResponse.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct MealListResponse: Codable {
    let meals: [MealListItemResponse]
}

struct MealListItemResponse: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
