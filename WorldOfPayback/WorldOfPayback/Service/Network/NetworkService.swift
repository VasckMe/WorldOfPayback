//
//  NetworkService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

final class NetworkService {
    private let executor: HTTPRequestExecutorProtocol
    private let persistenceService: PersistenceStorageServiceProtocol
    
    init(
        executor: HTTPRequestExecutorProtocol,
        persistenceService: PersistenceStorageServiceProtocol
    ) {
        self.executor = executor
        self.persistenceService = persistenceService
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        do {
            let response: PBTransactionsResponse = try await executor.execute(request: .transactionGET)
            return response.items.compactMap { PBTransaction(response: $0) }

        } catch {
            return try await handle(error: error)
        }
    }
}

// MARK: - Private

private extension NetworkService {
    func handle(error: Error) async throws -> [PBTransaction] {
        guard let networkError = error as? NetworkError else {
            throw error
        }
        
        switch networkError {
        case .offline:
            return await persistenceService.getTransactions()
        case .badResponse, .badParsing, .unknown:
            throw error
        }
    }
}
