//
//  ContentViewTests.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/11/23.
//

import XCTest
import Combine
@testable import Fetch_Test_Project

@MainActor class ContentViewTests: XCTestCase {
    
    var viewModel: ContentViewModel!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        viewModel = ContentViewModel()
    }
    
    func testInitialLoad() throws {
        let mealPublisher = viewModel.$meals
            .collect(2)
            .first()
        let meals = try waitForPublisher(publisher: mealPublisher, timeout: 10)

        XCTAssertFalse(meals.isEmpty)
        XCTAssertEqual(meals[1][0].strMeal, "Apam balik")
    }
    
    func testSearchBar() throws {
        let mealPublisher = viewModel.$meals
            .collect(2)
            .first()
        let meals = try waitForPublisher(publisher: mealPublisher, timeout: 10)
        
        viewModel.searchText = ""
        XCTAssertEqual(meals[1].count, viewModel.searchMeals.count)
        
        viewModel.searchText = "Apple"
        XCTAssertEqual(viewModel.searchMeals.count, 3)
        XCTAssertEqual(viewModel.searchMeals[0].idMeal, "52893")
        XCTAssertEqual(viewModel.searchMeals[1].idMeal, "52768")
        XCTAssertEqual(viewModel.searchMeals[2].idMeal, "52910")
    }

}
