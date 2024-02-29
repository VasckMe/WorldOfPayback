//
//  MockNetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class MockNetworkService {
}

// MARK: - NetworkServiceProtocol

extension MockNetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        
        let list = PBTransactionResponse.mockedResponse()

        return list.compactMap { PBTransaction(response: $0) }
    }
}

extension PBTransactionResponse {
    static func mockedResponse() -> [PBTransactionResponse] {
        do {
            guard
                let bundlePath = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                return []
            }
            
            let response = try JSONDecoder().decode(PBTransactionsResponse.self, from: jsonData)
            return response.items
        } catch {
            print(error)
            return []
        }
    }
}
