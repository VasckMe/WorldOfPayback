//
//  String+Localizable.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

import Foundation

enum LocalizableTable: String {
    case base = "Localizable"
}

extension String {
    func localized(_ table: LocalizableTable = .base) -> String {
        return NSLocalizedString(self, tableName: table.rawValue, comment: "")
    }
}
