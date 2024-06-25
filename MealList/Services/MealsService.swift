//
//  MealsService.swift
//  MealList
//
//  Created by Apple on 6/23/24.
//

import Foundation

protocol MealsServiceProtocol {
    func getMealsByCategory(categoryName: String) async throws -> MealListResponse
    func getMealDetail(mealId: String) async throws -> MealDetailResponse
}

struct MealsService: MealsServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getMealsByCategory(categoryName: String) async throws -> MealListResponse {
        let queries = ["c": categoryName]
        
        let request = APIRequest(path: "/filter.php", queries: queries)
        return try await apiClient.call(request)
    }
    
    func getMealDetail(mealId: String) async throws -> MealDetailResponse {
        let queries = ["i": mealId]
        
        let request = APIRequest(path: "/lookup.php", queries: queries)
        return try await apiClient.call(request)
    }
}
