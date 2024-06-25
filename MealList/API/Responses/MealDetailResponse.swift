//
//  MealDetailResponse.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct MealDetailResponse: Codable {
    let meals: [MealItemDetailResponse]
}

struct MealItemDetailResponse: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredients: [String]
    let strMeasures: [String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
               
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var ingredientsDic = [String: String]()
        var measuresDic = [String: String]()
        var ingredients = [String]()
        var measures = [String]()
        
        for key in dynamicContainer.allKeys {
            if key.stringValue.starts(with: "strIngredient") {
                if let ingredient = try? dynamicContainer.decode(String.self, forKey: key) {
                    ingredientsDic[key.stringValue] = ingredient
                }
            } else if key.stringValue.starts(with: "strMeasure") {
                if let measure = try? dynamicContainer.decode(String.self, forKey: key), !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    measuresDic[key.stringValue] = measure
                }
            }
        }

        
        for i in 1 ..< ingredientsDic.count {
            if let ingredient = ingredientsDic["strIngredient\(i)"],  !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredients.append(ingredient)
            }
        }
        
        for i in 1 ..< measuresDic.count {
            if let measure = measuresDic["strMeasure\(i)"],  !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                measures.append(measure)
            }
        }
        
        self.strIngredients = ingredients
        self.strMeasures = measures
    }
}
