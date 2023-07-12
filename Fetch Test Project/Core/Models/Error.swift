//
//  Error.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL(String), noResponse(String)
}
