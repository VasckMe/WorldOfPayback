//
//  PersistenceStorageServiceProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

protocol PersistenceStorageServiceProtocol {
    func save(transactions: [PBTransaction]) async throws
    func getTransactions() async throws -> [PBTransaction]
}
