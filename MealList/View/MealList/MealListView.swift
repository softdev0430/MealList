//
//  MealListView.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel: MealListViewModel
    
    init(viewModel: MealListViewModel = MealListViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.categoryName)
                    .font(.title)
                
                List {
                    ForEach($viewModel.meals, id:\.id) { $meal in
                        NavigationLink(destination: MealDetailView(viewModel: MealDetailViewModel(mealId: meal.id))) {
                            HStack(spacing: 10) {
                                AsyncImage(url: meal.thumbnailUrl) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                
                                Text(meal.mealName)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .task {
            await viewModel.getMealsByCategory()
        }
    }
}
