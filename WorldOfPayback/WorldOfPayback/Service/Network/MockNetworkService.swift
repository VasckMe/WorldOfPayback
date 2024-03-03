//
//  MockNetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class MockNetworkService {
    private let persistenceService: PersistenceStorageServiceProtocol
    
    init(persistenceService: PersistenceStorageServiceProtocol) {
        self.persistenceService = persistenceService
    }
}

// MARK: - NetworkServiceProtocol

extension MockNetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        await Task(priority: .medium) {
          await withUnsafeContinuation { continuation in
            Thread.sleep(forTimeInterval: 1)
            continuation.resume()
          }
        }.value
        
        do {
            guard
                let bundlePath = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            else {
                throw NetworkError.unknown
            }
            
            let response = try JSONDecoder().decode(PBTransactionsResponse.self, from: jsonData)
            let transactions = response.items.compactMap { PBTransaction(response: $0) }
            try await persistenceService.save(transactions: transactions)
            
            return transactions
        } catch {
            return try await handle(error: error)
        }
    }
}

// MARK: - Private

private extension MockNetworkService {
    func handle(error: Error) async throws -> [PBTransaction] {
        guard let networkError = error as? NetworkError else {
            throw error
        }
        
        switch networkError {
        case .offline:
            return try await persistenceService.getTransactions()
        case .badResponse, .badParsing, .unknown:
            throw error
        }
    }
}
