//
//  PhotoPersistenceHelper.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct EntryPersistenceHelper {
    static let manager = EntryPersistenceHelper()
    
    func save(entry: CollectionModel) throws {
        try persistenceHelper.save(newElement: entry)
    }
    
    func getEntries() throws -> [CollectionModel] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteFavorite(with collectionName: String) throws {
        do {
            let entries = try getEntries()
            let newEntries = entries.filter {$0.collectionName != collectionName }
            try persistenceHelper.replace(elements: newEntries)
        }
    }
    
    func editEntry(editEntry: CollectionModel, index: Int) throws {
        do {
            try persistenceHelper.update(updatedElement: editEntry, index: index)
        } catch {
            print(error)
        }
        
    }
    private let persistenceHelper = PersistenceHelper<CollectionModel>(fileName: "venueCollection.plist")
    
    private init() {}
}
