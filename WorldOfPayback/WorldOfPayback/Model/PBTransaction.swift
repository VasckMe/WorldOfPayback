//
//  PBTransaction.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

struct PBTransaction: Identifiable, Hashable {
    let id: Int
    let partnerDisplayName: String
    let category: Int
    let description: String?
    let bookingDate: Date
    let amount: Int
    let currency: String
}
