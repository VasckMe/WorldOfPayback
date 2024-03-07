//
//  DummyNetworkService.swift
//  WorldOfPaybackTests
//
//  Created by Anton Kasaryn on 7.03.24.
//

@testable import WorldOfPayback

struct DummyNetworkService: NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction] {
        return []
    }
}
