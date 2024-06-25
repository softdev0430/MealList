//
//  MealDetailView.swift
//  MealList
//
//  Created by Apple on 6/22/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: MealDetailViewModel
    
    init(viewModel: MealDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let mealDetail = viewModel.mealDetail {
                    AsyncImage(url: mealDetail.thumbnailUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 400)
                    
                    Text(mealDetail.innstructions)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    ingredientsView(mealDetail)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.mealName)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .task {
            await viewModel.getMealDetail()
        }
    }
    
    @ViewBuilder
    private func ingredientsView(_ mealDetail: MealDetailModel) -> some View {
        if mealDetail.ingredients.count > 0 {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingridients")
                
                ForEach(Array(mealDetail.ingredients.keys), id: \.self) { ingridient in
                    if let measure = mealDetail.ingredients[ingridient] {
                        HStack {
                            Text(ingridient)
                            Spacer()
                            Text(measure)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                        Divider()
                    }
                }
            }
            .padding(.top, 10)
        }
    }
    
    private var backButton : some View {
        Button {
            self.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.black)
        }
    }
}
