//
//  FetchOA2Tests.swift
//  FetchOA2Tests
//
//  Created by Mason Adams on 1/14/24.
//

import XCTest
@testable import FetchOA2

final class FetchOA2Tests: XCTestCase {

    var recipeModel: RecipeViewModel!
    var detailModel: DetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        recipeModel = RecipeViewModel()
        detailModel = DetailViewModel()
    }

    override func tearDownWithError() throws {
        recipeModel = nil
        detailModel = nil
        try super.tearDownWithError()
    }

    func testGetRecipes() async throws {
        try await recipeModel.getDesserts()
        XCTAssertFalse(recipeModel.recipes.isEmpty)
    }
    
    func testGetDetail() async throws {
        try await detailModel.getDetails(id: "52793")
        XCTAssertNotNil(detailModel.details.first)
        XCTAssertEqual("Sticky Toffee Pudding Ultimate", detailModel.details.first?.strMeal)
    }

}
