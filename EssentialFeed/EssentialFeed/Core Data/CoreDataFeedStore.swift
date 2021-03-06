//
//  CoreDataFeedStore.swift
//  NetworkModularization
//
//  Created by Shilpa Bansal on 04/03/21.
//

import Foundation
import CoreData

public class CoreDataFeedStore: FeedStore {
    public func deleteFeeds(completion: @escaping DeletionCompletion) {
        perform { context in
                completion(Result {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            })
        }
    }
    
    private let persistentContainer: NSPersistentContainer
    private let managedContext: NSManagedObjectContext
    
    public init(storeURL: URL) throws {
        let modelName = "FeedStoreDataModel"
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        
        guard let model = NSManagedObjectModel.with(name: modelName, in: storeBundle) else {
            throw NSError(domain: "Couldn't find the object model in Bundle", code: 0, userInfo: nil)
        }
        
        persistentContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)
        
        try persistentContainer.load(storeURL: storeURL)
        managedContext = persistentContainer.newBackgroundContext()
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let managedContext = self.managedContext
        managedContext.perform { action(managedContext) }
    }
    
    public func insert(feeds: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        perform { context in
            completion(Result {
                let managedCache = try ManagedCache.uniqueNewInstance(context: context, timestamp: timestamp)
                managedCache.feeds = ManagedFeed.images(from: feeds, in: context)

                try context.save()
            })
        }
    }
    
    public func retrieve(completion: @escaping RetrieveCompletion) {
        perform { context in
            completion(Result {
                try ManagedCache.find(in: context).map {
                    return CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            })
            
            /**
             Result has an initializer that accepts a throwing closure: if the closure returns a value successfully that gets used for the success case, otherwise the thrown error is placed into the failure case.
             
             replacement of below code
             do {
                 let feeds = try ManagedCache.find(in: context).map {
                     return CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                 }
                 completion(.success(feeds))
             }
             catch {
                 completion(.failure(error))
             }
             */
        }
    }
}

extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
    
    static func urlWith(name: String, in bundle: Bundle) -> URL? {
        return bundle
            .url(forResource: name, withExtension: "momd")
    }
}

extension NSPersistentContainer {
    func load(storeURL: URL) throws {
        let description = NSPersistentStoreDescription(url: storeURL)
        self.persistentStoreDescriptions = [description]
        
        var loadError: Swift.Error?
        loadPersistentStores { loadError = $1 }
        
        if let loadError = loadError {
            throw loadError
        }
    }
}
