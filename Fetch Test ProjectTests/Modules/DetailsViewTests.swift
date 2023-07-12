//
//  DetailsViewTests.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/12/23.
//

import XCTest
import Combine
@testable import Fetch_Test_Project

final class DetailsViewTests: XCTestCase {

    var viewModel: DetailsViewModel!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testInitialLoad() throws {
        viewModel = DetailsViewModel(id: "52768")
        let detailPublisher = viewModel.$mealDetails
            .collect(2)
            .first()
        let details = try waitForPublisher(publisher: detailPublisher, timeout: 10).dropFirst()
        
       
        XCTAssertNotNil(details.first)
        XCTAssertEqual(details.first!.strMeal, "Apple Frangipan Tart")
        XCTAssertFalse(details.first!.strIngredients.isEmpty)
        XCTAssertFalse(viewModel.displayError)
    }
    
    func testInvalidID() throws {
        viewModel = DetailsViewModel(id: "some invalid id")
        let detailPublisher = viewModel.$mealDetails
            .collect(2)
            .first()
        let _ = try waitForPublisher(publisher: detailPublisher, timeout: 10)
        
        XCTAssertTrue(viewModel.displayError)
    }
}
