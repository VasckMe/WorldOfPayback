//
//  ServiceAssembly.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 1.03.24.
//

import Foundation

final class ServiceAssembly {
    static let shared = ServiceAssembly()
    
    let networkService: NetworkServiceProtocol = NetworkService(
        executor: NetworkAssembly.requestExecutor
    )
    
    let persistenceService: PersistenceStorageService = PersistenceStorageService(
        persistenceManager: PersistenceStorageManager.shared
    )
    
    let mockNetworkService: NetworkServiceProtocol = MockNetworkService(
        persistenceService: PersistenceStorageService(persistenceManager: PersistenceStorageManager.shared)
    )
}
