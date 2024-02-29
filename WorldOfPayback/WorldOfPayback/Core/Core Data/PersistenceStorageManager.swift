//
//  PersistenceStorageManager.swift
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

final class PersistenceStorageManager {
    
    private let containerName = "Transaction"
    
    static let shared: PersistenceStorageManagerProtocol = PersistenceStorageManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.main.url(forResource: containerName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        let container = NSPersistentContainer(name: containerName, managedObjectModel: managedObjectModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })


        return container
    }()

    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
//    private(set) lazy var context: NSManagedObjectContext = {
//        persistentContainer.newBackgroundContext()
//    }()
//
//    private let persistentContainer: NSPersistentContainer
    
    required init() {
//        let container = NSPersistentContainer(name: containerName)
//        container.loadPersistentStores { _, error in
//            if let error = error as? NSError {
//                print(error)
//            }
//        }
//        persistentContainer = container
//        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

// MARK: - PersistanceStorageManagerProtocol

extension PersistenceStorageManager: PersistenceStorageManagerProtocol {
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }
    
    func retrieveObjects<T: NSManagedObject>(type: T.Type) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            throw PersistenceStorageManagerError.fetchError
        }
        
    }
    
    func deleteObjects<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil) throws {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            
            result.forEach { context.delete($0) }
        } catch {
            throw PersistenceStorageManagerError.fetchError
        }
    }
}
