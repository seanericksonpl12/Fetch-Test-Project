//
//  NetworkTests.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/11/23.
//

import XCTest
import Combine
import SwiftyJSON
@testable import Fetch_Test_Project

final class NetworkTests: XCTestCase {
    
    var network: NetworkManager!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        network = NetworkManager.main
    }
    
    func testGetMeals() throws {
        let meals = try waitForPublisher(publisher: network.getMeal(), timeout: 10)
        
        XCTAssertFalse(meals.isEmpty)
        XCTAssertTrue(meals.allSatisfy { $0.strMeal != "" })
    }
    
    func testGetDetails() throws {
        let id = "52767"
        let details = try waitForPublisher(publisher: network.getMealDetails(id: id), timeout: 10)
        XCTAssertNotNil(details.strMealThumb)
        XCTAssertEqual(details.strMeal, "Bakewell tart")
        XCTAssertEqual(details.strArea, "British")
        XCTAssertNotNil(details.strMealThumb)
        XCTAssertFalse(details.strIngredients.contains { $0.name == "" })
    }
    
    func testSortJSONEmptyInput() {
        let json = JSON(parseJSON: "[]")
        do {
            let _ = try network.sortJSON(json: json)
            XCTFail()
        } catch {}
    }
    
    func testSortJSONGoodInput() {
        let jsonStr = "{ \"meals\" : [ { \"strMeal\" : \"TestMeal\", \"idMeal\" : \"TestID\", \"strIngredient1\" : \"testIngredient1 \", \"strMeasurement1\" : \" testMeasurement1\", \"strIngredient2\" : \"testIngredient2\", \"strMeasurement2\" : \"testMeasurement2 \"} ] }"
        let json = JSON(parseJSON: jsonStr)
        var details: MealDetails = MealDetails()
        
        do {
            details = try network.sortJSON(json: json)
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(details.idMeal, "TestID")
        XCTAssertEqual(details.strMeal, "TestMeal")
        XCTAssertEqual(details.strIngredients.count, 2)
        XCTAssertEqual(details.strIngredients[0].name, "testMeasurement1 testIngredient1")
        XCTAssertEqual(details.strIngredients[1].name, "testMeasurement2 testIngredient2")
    }

}
