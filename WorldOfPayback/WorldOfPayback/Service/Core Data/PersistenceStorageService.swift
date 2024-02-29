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
    
    func save(transactions: [PBTransaction]) async {
        await persistenceManager.context.perform { [weak self] in
            guard let self = self else {
                return
            }
            
            try? self.persistenceManager.deleteObjects(type: Transaction.self, predicate: nil)
            
            transactions.forEach {
                let transactionModel = Transaction(context: self.persistenceManager.context)
                transactionModel.id = Int64($0.id)
                transactionModel.partnerDisplayName = $0.partnerDisplayName
                transactionModel.category = Int64($0.category)
                transactionModel.transactionDescription = $0.description
                transactionModel.bookingDate = $0.bookingDate
                transactionModel.amount = Int64($0.amount)
                transactionModel.currency = $0.currency
            }
            
            self.persistenceManager.save()
        }
    }
    
    func getTransactions() async -> [PBTransaction] {
        await persistenceManager.context.perform { [weak self] in
            guard let self = self else {
                return []
            }
            
            do {
                let transactions = try self.persistenceManager.retrieveObjects(type: Transaction.self)
                return transactions.compactMap { PBTransaction(model: $0) }
            } catch {
                return []
            }
        }
    }
}
