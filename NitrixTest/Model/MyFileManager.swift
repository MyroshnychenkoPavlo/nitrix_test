//
//  MyFileManager.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import UIKit
import RealmSwift

// MARK: - MyFileManager
class MyFileManager {

    // MARK: - Public properties
    static let shared = MyFileManager()
    
    // MARK: - Private properties
    private let databaseService = DatabaseService<Movie>()
    
    // MARK: - Lifecycle
    private init() { }

    // MARK: - Public methods
    func getFiles() -> [Movie] {
        return databaseService.getObjects()
    }
    
    func delete(_ file: Movie) {
        databaseService.delete(object: file)
    }
    
    func replaceFile(object: Movie) {
        if let existingObject = databaseService.getObjects().first {
            databaseService.delete(object: existingObject)
        }
        databaseService.add(object: object)
    }
    
    func delete(_ files: [Movie]) {
        databaseService.delete(objects: files)
    }
    
    func deleteAll() {
        databaseService.deleteAll()
    }
    
    func add(_ file: Movie) {
        databaseService.add(object: file)
    }
    
    func add(_ files: [Movie]) {
        databaseService.add(objects: files)
    }
    
    func logout() {
        DatabaseService().clearDataBase()
    }
    
    func contains(_ file: Movie) -> Bool {
        return databaseService.getObjects().contains(where: { $0.id == file.id })
    }
}
