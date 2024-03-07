//
//  NetworkServiceSpy.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

@testable import WorldOfPayback
import Foundation

final class NetworkServiceSpy: NetworkServiceProtocol {
    var callFetch = false
    var callFetchCount = 0
    
    private let requestExecutor: HTTPRequestExecutorProtocol
        
    init(requestExecutor: HTTPRequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func fetchTransactions() async throws -> [PBTransaction] {
        callFetch = true
        callFetchCount += 1
        
        do {
            let response: PBTransactionsResponse = try await requestExecutor.execute(request: .transactionGET)
            return response.items.compactMap { PBTransaction(response: $0) }
        } catch {
            throw error
        }
    }
}
