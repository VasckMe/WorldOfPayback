//
//  PersistenceStorageServiceSpy.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 3.03.24.
//

import Foundation
@testable import WorldOfPayback

final class PersistenceStorageServiceSpy: PersistenceStorageServiceProtocol {
    var callSave = false
    var callSaveCount = 0
    var stockSaveError: Error?
    var stockSaveTransactions: [PBTransaction] = []
    
    var callGetTransactions = false
    var callGetTransactionsCount = 0
    var stockGetTransactionsError: Error?
    var stockGetTransactions: [PBTransaction] = []
    
    func save(transactions: [PBTransaction]) async throws {
        callSave = true
        callSaveCount += 1
        
        await Task(priority: .medium) {
            await withUnsafeContinuation { continuation in
                Thread.sleep(forTimeInterval: 1)
                continuation.resume()
            }
        }.value
        
        if let error = stockSaveError {
            throw error
        } else {
            stockSaveTransactions = transactions
        }
    }
    
    func getTransactions() async throws -> [PBTransaction] {
        callGetTransactions = true
        callGetTransactionsCount += 1
        
        await Task(priority: .medium) {
            await withUnsafeContinuation { continuation in
                Thread.sleep(forTimeInterval: 1)
                continuation.resume()
            }
        }.value
        
        if let error = stockGetTransactionsError {
            throw error
        } else {
            return stockGetTransactions
        }
    }
}
