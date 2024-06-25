//
//  MealListModel.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct MealListItemModel {
    let id: String
    let mealName: String
    let thumbnailUrl: URL?
    
    init(from response: MealListItemResponse) {
        self.id = response.idMeal
        self.mealName = response.strMeal
        self.thumbnailUrl = URL(string: response.strMealThumb)
    }
}

