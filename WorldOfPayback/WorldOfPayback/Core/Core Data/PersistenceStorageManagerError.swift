//
//  PersistenceStorageManagerError.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

enum PersistenceStorageManagerError: Error {
    case invalidContextFetch
    case invalidContextSave
    case invalidFetchedModelForCasting
    case unknown
}
