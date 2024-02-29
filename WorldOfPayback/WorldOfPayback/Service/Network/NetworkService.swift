//
//  NetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

final class NetworkService {
    private let executor: HTTPRequestExecutorProtocol
    
    init(executor: HTTPRequestExecutorProtocol) {
        self.executor = executor
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        let response: PBTransactionsResponse = try await executor.execute(request: .transactionGET)
        return response.items.compactMap { PBTransaction(response: $0) }
    }
}
