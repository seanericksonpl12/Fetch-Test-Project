//
//  CollectionExtensionTests.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/12/23.
//

import XCTest
@testable import Fetch_Test_Project

final class CollectionExtensionTests: XCTestCase {
    
    var arr: [Int]!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        arr = [1, 2, 3, 4]
    }
    
    func testArr() {
        XCTAssertEqual(arr[2], 3)
        XCTAssertNil(arr[safe: 5])
    }

}
