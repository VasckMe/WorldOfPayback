//
//  PBTransactionResponse.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

struct PBTransactionResponse: Decodable {
    let partnerDisplayName: String
    let alias: PBTransactionAliasResponse
    let category: Int
    let transactionDetail: PBTransactionDetailResponse
}
