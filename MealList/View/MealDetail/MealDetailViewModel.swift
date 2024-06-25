//
//  MealDetailViewModel.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

struct Ingredient: Identifiable {
    let name: String
    let measure: String
    let id = UUID()
}

final class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetailModel?
    
    var mealName: String {
        if let mealDetail = mealDetail {
            return mealDetail.mealName
        } else {
            return ""
        }
    }
    private var mealId: String
    
    private let mealService: any MealsServiceProtocol
    
    init(mealService: any MealsServiceProtocol = MealsService(), mealId: String) {
        self.mealService = mealService
        self.mealId = mealId
    }

    @MainActor
    func getMealDetail() async {
        do {
            let mealsDetail = try await mealService.getMealDetail(mealId: mealId)
            
            if mealsDetail.meals.count > 0 {
                mealDetail = MealDetailModel(from: mealsDetail.meals[0])
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
