//
//  DatabaseService.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import Foundation
import RealmSwift

// MARK: - DatabaseServiceProtocol
protocol DatabaseServiceProtocol {
    associatedtype EntityType
    
    func getObjects() -> [EntityType]
    func add(object: EntityType)
    func delete(object: EntityType)
    func delete(objects: [EntityType])
    func edit(_ block: @escaping () -> Void)
    func clearDataBase()
}

// MARK: - DatabaseService
final class DatabaseService<T: Object>: DatabaseServiceProtocol {
    
    // MARK: - Private properties
    private var realm: Realm {
        return try! Realm()
    }
    private var databaseServiceQueue: DispatchQueue
    
    // MARK: - Lifecycle
    init() {
        databaseServiceQueue = DispatchQueue(label: "databaseServiceQueue", qos: .background, attributes: .concurrent)
    }
    
    // MARK: - Public methods
    func getObjects() -> [T] {
        var objects: [T]!
        databaseServiceQueue.sync {
            objects = realm.objects(T.self).map { $0 }
        }
        return objects
    }
    
    func getObjectsWith(predicate: String, _ args: Any...) -> [T] {
        var objects: [T]!
        objects = realm.objects(T.self).filter(predicate, args).map { $0 }
        return objects
    }
    
    func add(object: T) {
        self.edit {
            self.realm.add(object)
        }
    }
    
    func add(objects: [T]) {
        self.edit {
            self.realm.add(objects)
        }
    }
    
    func delete(object: T) {
        self.edit {
            self.realm.delete(object)
        }
    }
    
    func delete(objects: [T]) {
        self.edit {
            self.realm.delete(objects)
        }
    }
    
    func deleteAll() {
        let objects = self.getObjects()
        self.delete(objects: objects)
    }
    
    func edit(_ block: @escaping () -> Void) {
        try! realm.write {
            block()
        }
    }
    
    func clearDataBase() {
        self.edit {
            self.realm.deleteAll()
        }
    }
}
