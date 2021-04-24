//
//  UIRefreshControl+testHelpers.swift
//  EssentialFeedTests
//
//  Created by Shilpa Bansal on 24/04/21.
//

import UIKit
private extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach({target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach({
                (target as NSObject).perform(Selector($0))
            })
        })
    }
}
