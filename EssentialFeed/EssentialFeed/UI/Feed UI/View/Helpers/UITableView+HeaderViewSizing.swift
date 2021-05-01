//
//  UITableView+HeaderViewSizing.swift
//  EssentialFeed
//
//  Created by Shilpa Bansal on 01/05/21.
//

import UIKit
extension UITableView {
    func sizeTableHeaderViewToFit() {
        guard let header = tableHeaderView else { return }

        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
