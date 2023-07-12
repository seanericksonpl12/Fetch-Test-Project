//
//  NetworkTests.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/11/23.
//

import XCTest
import Combine
@testable import Fetch_Test_Project

final class NetworkTests: XCTestCase {
    
    var network: NetworkManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        network = NetworkManager.main
        cancellables = []
    }
    
    func testGetMeals() throws {
        let meals = try waitForPublisher(publisher: network.getMeal(), timeout: 5)
        
        XCTAssertFalse(meals.isEmpty)
        XCTAssertTrue(meals.allSatisfy { $0.strMeal != "" })
    }
    
    func testGetDetails() throws {
        let id = "52767"
        let details = try waitForPublisher(publisher: network.getMealDetails(id: id), timeout: 5)
        XCTAssertNotNil(details.strMealThumb)
        XCTAssertEqual(details.strMeal, "Bakewell tart")
        XCTAssertEqual(details.strArea, "British")
        XCTAssertFalse(details.strIngredients.contains { $0.name == "" })
    }

}
