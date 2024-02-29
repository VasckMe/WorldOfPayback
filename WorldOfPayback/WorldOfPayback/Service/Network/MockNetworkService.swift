//
//  MockNetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class MockNetworkService {
    private let persistenceSerivce: PersistenceStorageServiceProtocol
    init() {
        self.persistenceSerivce = PersistenceStorageService(persistenceManager: PersistenceStorageManager())
    }
}

// MARK: - NetworkServiceProtocol

extension MockNetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        
        let list = PBTransactionResponse.mockedResponse()

        let transactions = list.compactMap { PBTransaction(response: $0) }
        
//        await persistenceSerivce.save(transactions: transactions)
//        return persistenceSerivce.getTransactions()
        return transactions
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
            return []
        }
    }
}
