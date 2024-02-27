//
//  NetworkServiceProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

protocol NetworkServiceProtocol {
    func fetchTransactions() async throws -> [PBTransaction]
}
