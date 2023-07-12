//
//  ClosureTypes.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import Foundation

// MARK: - Foundation/Basic Types
typealias StringClosure = (String) -> Void
typealias IntClosure = (Int) -> Void
typealias FloatClosure = (CGFloat) -> Void
typealias BoolClosure = (Bool) -> Void
typealias ArrayClosure<T> = (Array<T>) -> Void
typealias DateClosure = (Date) -> Void
typealias UrlClosure = (URL) -> Void
