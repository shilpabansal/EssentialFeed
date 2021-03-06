//
//  SharedFeedHelper.swift
//  NetworkModularizationTests
//
//  Created by Shilpa Bansal on 26/01/21.
//

import Foundation
@testable import EssentialFeed

func anyNSError() -> NSError {
    return NSError(domain: "Test Error", code: 1)
}

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}
