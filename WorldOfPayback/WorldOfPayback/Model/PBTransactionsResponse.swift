//
//  PBTransactionsResponse.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

struct PBTransactionsResponse: Decodable {
    let items: [PBTransactionResponse]
}
