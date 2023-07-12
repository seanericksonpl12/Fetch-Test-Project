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
    
    var view: ContentView!
    var cancellables: Set<AnyCancellable>!

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        view = ContentView()
    }
    
    func testInitialLoad() throws {
        let viewModel = ContentViewModel()
        let mealPublisher = viewModel.$meals
            .collect(2)
            .first()
        let meals = try waitForPublisher(publisher: mealPublisher, timeout: 5)

        XCTAssertFalse(meals.isEmpty)
        XCTAssertEqual(meals[1][0].strMeal, "Apam balik")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
