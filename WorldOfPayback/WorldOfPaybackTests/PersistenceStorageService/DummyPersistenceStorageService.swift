//
//  DummyPersistenceStorageService.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 7.03.24.
//

import Foundation
@testable import WorldOfPayback

struct DummyPersistenceStorageService: PersistenceStorageServiceProtocol {
    func save(transactions: [WorldOfPayback.PBTransaction]) async throws {
    }
    
    func getTransactions() async throws -> [WorldOfPayback.PBTransaction] {
        return []
    }
}
