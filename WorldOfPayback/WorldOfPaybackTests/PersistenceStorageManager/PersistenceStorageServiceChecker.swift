//
//  PersistenceStorageServiceChecker.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import Foundation
@testable import WorldOfPayback

final class PersistenceStorageServiceChecker: PersistenceStorageServiceProtocol {
    var calledSaveMethod = false
    var callSaveMethodCount = 0
    var saveResultError: Error?
    
    var calledGetTransactionsMethod = false
    var callGetTransactionsMethodCount = 0
    var getTransactionResultError: Error?
    var getTransactionResultSuccess: [PBTransaction] = []
    
    func save(transactions: [PBTransaction]) async throws {
        calledSaveMethod = true
        callSaveMethodCount += 1
    }
    
    func getTransactions() async throws -> [PBTransaction] {
        calledGetTransactionsMethod = true
        callGetTransactionsMethodCount += 1
        
        await Task(priority: .medium) {
            
          await withUnsafeContinuation { continuation in
            Thread.sleep(forTimeInterval: 1)
            continuation.resume()
          }
            
        }.value
        
        if let error = getTransactionResultError {
            throw error
        } else {
            return getTransactionResultSuccess
        }
    }
}
