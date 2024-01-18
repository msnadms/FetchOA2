//
//  DetailViewModel.swift
//  FetchOA2
//
//  Created by Mason Adams on 1/17/24.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var details: [RecipeDetail] = []
    
    private let controller = MealsController()
    private let detailUrlString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    @MainActor
    func getDetails(id: String) async throws {
        guard let url: URL = URL(string: detailUrlString + id) else { return }
        details = try await controller.getDetails(url: url)
    }
}
