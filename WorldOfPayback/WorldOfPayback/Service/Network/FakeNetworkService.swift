//
//  FakeNetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

import Foundation

final class FakeNetworkService: NetworkServiceProtocol {
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
            
            return transactions
        } catch {
            throw error
        }
    }
}
