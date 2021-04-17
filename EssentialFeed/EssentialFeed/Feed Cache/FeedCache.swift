//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Shilpa Bansal on 17/04/21.
//

public protocol FeedCache {
    typealias SaveResult = Swift.Result<Void, Error>
    func saveFeedInCache(feeds: [FeedImage], timestamp: Date, completion: @escaping (SaveResult) -> Void)
}
