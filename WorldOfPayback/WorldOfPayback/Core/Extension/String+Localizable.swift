//
//  String+Localizable.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

extension String {
    var localized: String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
