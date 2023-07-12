//
//  CollectionExtension.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
