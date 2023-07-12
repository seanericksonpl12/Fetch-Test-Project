//
//  StringExtension.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import Foundation

extension String {
    var localized: String { String(NSLocalizedString(self, comment: "")) }
}
