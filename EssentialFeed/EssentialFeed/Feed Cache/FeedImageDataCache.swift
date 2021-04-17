//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Shilpa Bansal on 17/04/21.
//

import Foundation

public  protocol  FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
