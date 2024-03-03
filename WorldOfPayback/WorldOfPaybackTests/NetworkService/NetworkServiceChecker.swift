//
//  NetworkServiceChecker.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

@testable import WorldOfPayback
import Foundation

class NetworkServiceChecker: NetworkServiceProtocol {
    
    var calledMethod = false
    var callMethodCount = 0
    
    var didGetExecutorResponse = false
    var didGetPersistenceResponse = false
    
    var resultError: Error?
    var resultSuccess: [PBTransaction] = []
    
    var persistenceStorageService: PersistenceStorageServiceProtocol
    var requestExecutor: HTTPRequestExecutorProtocol
        
    init(persistenceStorageService: PersistenceStorageServiceProtocol, requestExecutor: HTTPRequestExecutorProtocol) {
        self.persistenceStorageService = persistenceStorageService
        self.requestExecutor = requestExecutor
    }
    
    func fetchTransactions() async throws -> [PBTransaction] {
        calledMethod = true
        callMethodCount += 1
        
        do {
            let response: PBTransactionsResponse = try await requestExecutor.execute(request: .transactionGET)
            didGetExecutorResponse = true
            return response.items.compactMap { PBTransaction(response: $0) }
        } catch {
            didGetExecutorResponse = true
            return try await handle(error: error)
        }
    }
    
    private func handle(error: Error) async throws -> [PBTransaction] {
        guard let networkError = error as? NetworkError else {
            throw error
        }
        
        switch networkError {
        case .offline:
            didGetPersistenceResponse = true
            return try await persistenceStorageService.getTransactions()
        case .badResponse, .badParsing, .unknown:
            throw error
        }
    }
}
