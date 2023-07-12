//
//  XCTestCaseExtension.swift
//  Fetch Test ProjectTests
//
//  Created by Sean Erickson on 7/11/23.
//

import Foundation
import Combine
import XCTest

extension XCTestCase {
    func waitForPublisher<T: Publisher>(publisher: T, timeout: TimeInterval, file: StaticString = #file, line: UInt = #line) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Waiting on Publisher")
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                result = .failure(error)
            }
            expectation.fulfill()
        } receiveValue: { value in
            result = .success(value)
        }
        
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        let endResults = try XCTUnwrap(result, "No output", file: file, line: line)
        return try endResults.get()
    }
}
