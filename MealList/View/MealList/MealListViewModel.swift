//
//  MealListViewModel.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import Foundation

final class MealListViewModel: ObservableObject {
    @Published var meals: [MealListItemModel] = []
    @Published var selectedId: String?
    var categoryName: String = ""
    
    private let mealService: any MealsServiceProtocol
    
    init(mealService: any MealsServiceProtocol = MealsService()) {
        self.mealService = mealService
    }

    @MainActor
    func getMealsByCategory(_ categoryName: String = "Dessert") async {
        self.categoryName = categoryName
        
        do {
            let mealList = try await mealService.getMealsByCategory(categoryName: categoryName)
            meals = mealList.meals.map { MealListItemModel(from: $0) }.sorted { $0.mealName < $1.mealName }
        } catch {
            print(error.localizedDescription)
        }
    }
}
