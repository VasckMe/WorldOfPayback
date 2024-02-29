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

extension PBTransactionResponse {
    static func mockedResponse() throws -> [PBTransactionResponse] {
        do {
            guard
                let bundlePath = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                throw NetworkError.unknown
            }
            
            let response = try JSONDecoder().decode(PBTransactionsResponse.self, from: jsonData)
            return response.items
        } catch {
            throw NetworkError.badParsing
        }
    }
}
