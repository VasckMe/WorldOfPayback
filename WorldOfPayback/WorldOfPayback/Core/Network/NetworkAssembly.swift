//
//  NetworkAssembly.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 1.03.24.
//

struct NetworkAssembly {
    static var requestExecutor: HTTPRequestExecutorProtocol {
        HTTPRequestExecutor(builder: HTTPRequestBuilder())
    }
}
