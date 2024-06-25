//
//  MealDetailModel.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct MealDetailModel {
    let id: String
    let mealName: String
    let thumbnailUrl: URL?
    let innstructions: String
    var ingredients = [String:String]()
    
    init(from response: MealItemDetailResponse) {
        self.id = response.idMeal
        self.mealName = response.strMeal
        self.thumbnailUrl = URL(string: response.strMealThumb)
        self.innstructions = response.strInstructions
        
        for (index, ingredient) in response.strIngredients.enumerated() {
            if response.strMeasures.count > index {
                ingredients[ingredient] = response.strMeasures[index]
            }
        }
    }
}
