//
//  ManagedFeed+CoreDataProperties.swift
//  NetworkModularization
//
//  Created by Shilpa Bansal on 04/03/21.
//
//

import Foundation
import CoreData


extension ManagedFeed {

    @nonobjc class func fetchRequest() -> NSFetchRequest<ManagedFeed> {
        return NSFetchRequest<ManagedFeed>(entityName: "ManagedFeed")
    }

    @NSManaged public var id: UUID
    @NSManaged var imageDescription: String?
    @NSManaged var location: String?
    @NSManaged var url: URL
    @NSManaged var cache: ManagedCache?
    @NSManaged var data: Data?
}

extension ManagedFeed : Identifiable {
    var feedImage: LocalFeedImage {
        return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
    }
    
    static func first(with url: URL, in context: NSManagedObjectContext) throws -> ManagedFeed? {
        let request = NSFetchRequest<ManagedFeed>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedFeed.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }

    static func images(from localFeed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedFeed(context: context)
            managed.id = local.id
            managed.imageDescription = local.description
            managed.location = local.location
            managed.url = local.url
            return managed
        })
    }
    
    var local: LocalFeedImage {
        return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
    }
}
