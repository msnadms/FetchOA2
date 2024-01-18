//
//  RecipeViewModel.swift
//  FetchOA2
//
//  Created by user250606 on 1/17/24.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Dessert] = []
    
    private let controller = MealsController()
    private let dessertUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    
    @MainActor
    func getDesserts() async throws {
        guard let url = dessertUrl else {return}
        recipes = try await controller.getDesserts(url: url)
    }

}
