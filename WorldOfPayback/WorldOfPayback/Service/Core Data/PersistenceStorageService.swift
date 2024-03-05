//
//  PersistenceStorageService.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

import CoreData

final class PersistenceStorageService: PersistenceStorageServiceProtocol {
    private let persistenceManager: PersistenceStorageManagerProtocol
    
    init(persistenceManager: PersistenceStorageManagerProtocol) {
        self.persistenceManager = persistenceManager
    }
    
    func save(transactions: [PBTransaction]) async throws {
        try await persistenceManager.context.perform { [weak self] in
            guard let self = self else {
                return
            }
            
            do {
                let savedTransactions = try self.persistenceManager.retrieveObjects(type: Transaction.self)
                
                try transactions.forEach {
                    let fetchID = $0.id
                    
                    guard let saveTransaction = savedTransactions.first(where: { $0.id == fetchID }) else {
                        // save new fetched transaction, if there is no similar in CD yet
                        self.save(transaction: $0)
                        return try self.persistenceManager.save()
                    }
                    
                    guard let businessSaveTransaction = PBTransaction(model: saveTransaction) else {
                        throw PersistenceStorageManagerError.invalidFetchedModelForCasting
                    }
                    
                    guard businessSaveTransaction != $0 else {
                        return
                    }
                    
                    try self.persistenceManager.deleteObjects(
                        type: Transaction.self,
                        predicate: NSPredicate(format: "id == %@", "\(businessSaveTransaction.id)")
                    )
                    
                    self.save(transaction: $0)
                    try self.persistenceManager.save()
                }
            } catch {
                throw error
            }
        }
    }
    
    func getTransactions() async throws -> [PBTransaction] {
        try await persistenceManager.context.perform { [weak self] in
            guard let self = self else {
                return []
            }
            
            do {
                let transactions = try self.persistenceManager.retrieveObjects(type: Transaction.self)
                return transactions.compactMap { PBTransaction(model: $0) }
            } catch {
                throw error
            }
        }
    }
}

private extension PersistenceStorageService {
    func save(transaction: PBTransaction) {
        let transactionModel = Transaction(context: self.persistenceManager.context)
        transactionModel.id = Int64(transaction.id)
        transactionModel.partnerDisplayName = transaction.partnerDisplayName
        transactionModel.category = Int64(transaction.category)
        transactionModel.transactionDescription = transaction.description
        transactionModel.bookingDate = transaction.bookingDate
        transactionModel.amount = Int64(transaction.amount)
        transactionModel.currency = transaction.currency
    }
}
