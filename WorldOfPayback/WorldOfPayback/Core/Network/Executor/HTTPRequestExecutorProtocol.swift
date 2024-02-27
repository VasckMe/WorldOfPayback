//
//  HTTPRequestExecutorProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 27.02.24.
//

protocol HTTPRequestExecutorProtocol {
    func execute<T: Decodable>(request: HTTPRequest) async throws -> T
}
