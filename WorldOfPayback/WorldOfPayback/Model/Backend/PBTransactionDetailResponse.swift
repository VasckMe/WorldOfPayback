//
//  PBTransactionDetailResponse.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

struct PBTransactionDetailResponse: Decodable {
    let description: String?
    let bookingDate: String
    let value: PBTransactionValueResponse
}
