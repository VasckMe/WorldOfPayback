//
//  PersistenceStorageManagerProtocol.swift
//  WorldOfPayback
//
//  Created by Anton Kasaryn on 29.02.24.
//

import CoreData

protocol PersistenceStorageManagerProtocol {
    func retrieveObjects<T: NSManagedObject>(type: T.Type) throws -> [T]
    func deleteObjects<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?) throws
    func save()
    
    var context: NSManagedObjectContext { get }
}
