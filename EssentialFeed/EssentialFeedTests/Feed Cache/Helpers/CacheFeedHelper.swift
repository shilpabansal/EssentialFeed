//
//  FeedHelper.swift
//  NetworkModularizationTests
//
//  Created by Shilpa Bansal on 26/01/21.
//

import Foundation
@testable import EssentialFeed

public func uniqueFeed() -> FeedImage {
    return FeedImage(id: UUID(), description: nil, location: nil, url: URL(string: "https://a-url.com")!)
}

public func uniqueFeeds() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: nil, location: nil, url: URL(string: "https://a-url.com")!)]
}

public func uniqueImageFeeds() -> (model: [FeedImage], local: [LocalFeedImage]) {
    let feeds = [uniqueFeed(), uniqueFeed()]
    let localFeeds = feeds.map({feed in
        LocalFeedImage(id: feed.id, description: feed.description, location: feed.location, url: feed.url)
    })
    
    return (model: feeds, local: localFeeds)
}

extension Date {
    func minusFeedCacheMaxAge() -> Date {
        return self.adding(days: -feedCacheMaxAgeInDays)
    }
    
    private var feedCacheMaxAgeInDays: Int {
        return 7
    }
    
    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}

extension Array where Element == FeedImage {
    func toModels() -> [FeedImage] {
        return map({return FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)})
    }
}

extension Array where Element == RemoteFeedItem {
    func toModels() -> [FeedImage] {
        return map({
            return FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.image)
        })
    }
}
