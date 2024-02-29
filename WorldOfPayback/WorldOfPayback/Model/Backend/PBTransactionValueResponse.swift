//
//  PBTransactionValueResponse.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

struct PBTransactionValueResponse: Decodable {
    let amount: Int
    let currency: String
}
