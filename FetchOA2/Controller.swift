//
//  Controller.swift
//  FetchOA2
//
//  Created by Mason Adams on 1/16/24.
//

import Foundation

struct RecipeDetail: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
        strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
        strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
        strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?

    let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
        strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
        strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
        strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
    
    var id: String { idMeal }
}

struct Dessert: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    var id: String { idMeal }
}

struct MealsResponse<T: Decodable>: Decodable {
    let meals: [T]
}

class MealsController {
    func getDesserts(url: URL) async throws -> [Dessert] {
        let data = try await URLSession.shared.data(from: url)
        let desserts = try? JSONDecoder().decode(MealsResponse<Dessert>.self, from: data.0)
        return desserts?.meals ?? []
    }
    func getDetails(url: URL) async throws -> [RecipeDetail] {
        let data = try await URLSession.shared.data(from: url)
        let recipeDetails = try? JSONDecoder().decode(MealsResponse<RecipeDetail>.self, from: data.0)
        return recipeDetails?.meals ?? []
    }
}
