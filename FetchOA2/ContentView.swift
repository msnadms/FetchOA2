//
//  ContentView.swift
//  FetchOA2
//
//  Created by Mason Adams on 1/14/24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    @Published var selectedDetail: RecipeDetail? = nil
}

struct ContentView: View {
    @ObservedObject private var viewModel = SharedViewModel()
    @StateObject private var recipeModel = RecipeViewModel()
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Text("Recipes").font(.title)
                List(recipeModel.recipes) { r in
                    RecipeView(selectedTab: $selectedTab, viewModel: viewModel, recipeName: r.strMeal, recipeId: r.idMeal)
                }.onAppear() {
                    Task {
                        try await recipeModel.getDesserts()
                    }
                }
            }.tabItem {
                Text("Recipes")
            }.tag(0)
            DetailView(viewModel: viewModel).tabItem {
                Text("Instructions")
            }.tag(1)
        }
    }
}

struct RecipeView: View {
    @Binding var selectedTab: Int
    @ObservedObject var viewModel: SharedViewModel
    @StateObject private var detailModel = DetailViewModel()
    let recipeName: String
    let recipeId: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.selectedDetail = detailModel.details.first
                    selectedTab = 1
                }) {
                    Text(recipeName)
                }.onAppear() {
                    Task {
                        try await detailModel.getDetails(id: recipeId)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 0).stroke(.blue, lineWidth: 1))
                Spacer()
            }
        }
    }
}

private func alignIM(i: String?, m: String?) -> Text {
    let ingredient: String = i ?? ""
    let measurement: String = m ?? ""
    let delimiter: String = (ingredient == "" || measurement == "") ? "" : " - "
    
    return Text(ingredient + delimiter + measurement).bold()
}

struct DetailView: View {
    @ObservedObject var viewModel: SharedViewModel
    var body: some View {
        let detail: RecipeDetail? = viewModel.selectedDetail
        VStack {
            Text(detail?.strMeal ?? "Select a recipe!").font(.title)
            ScrollView {
                Text(detail?.strInstructions ?? "").padding().multilineTextAlignment(.center)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            //There are exactly 20 ingredient and measurement fields returned by the api regardless of the recipe
            alignIM(i: detail?.strIngredient1, m: detail?.strMeasure1)
            alignIM(i: detail?.strIngredient2, m: detail?.strMeasure2)
            alignIM(i: detail?.strIngredient3, m: detail?.strMeasure3)
            alignIM(i: detail?.strIngredient4, m: detail?.strMeasure4)
            alignIM(i: detail?.strIngredient5, m: detail?.strMeasure5)
            alignIM(i: detail?.strIngredient6, m: detail?.strMeasure6)
            alignIM(i: detail?.strIngredient7, m: detail?.strMeasure7)
            alignIM(i: detail?.strIngredient8, m: detail?.strMeasure8)
            alignIM(i: detail?.strIngredient9, m: detail?.strMeasure9)
            alignIM(i: detail?.strIngredient10, m: detail?.strMeasure10)
            alignIM(i: detail?.strIngredient11, m: detail?.strMeasure11)
            alignIM(i: detail?.strIngredient12, m: detail?.strMeasure12)
            alignIM(i: detail?.strIngredient13, m: detail?.strMeasure13)
            alignIM(i: detail?.strIngredient14, m: detail?.strMeasure14)
            alignIM(i: detail?.strIngredient15, m: detail?.strMeasure15)
            alignIM(i: detail?.strIngredient16, m: detail?.strMeasure16)
            alignIM(i: detail?.strIngredient17, m: detail?.strMeasure17)
            alignIM(i: detail?.strIngredient18, m: detail?.strMeasure18)
            alignIM(i: detail?.strIngredient19, m: detail?.strMeasure19)
            alignIM(i: detail?.strIngredient20, m: detail?.strMeasure20)
        }
    }
}

#Preview {
    ContentView()
}
