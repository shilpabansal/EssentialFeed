//
//  FeedImageViewModel.swift
//  NetworkModularization
//
//  Created by Shilpa Bansal on 21/03/21.
//

public struct FeedImageViewModel<Image> {
    public var location: String?
    public var description: String?
    public var image: Image?
    public var isLoading: Bool
    public var showRetry: Bool
    
    public var hasLocation: Bool {
        return location != nil
    }
    
    public init(location: String?,
                description: String?,
                image: Image?,
                isLoading: Bool,
                showRetry: Bool) {
        self.location = location
        self.description = description
        self.image = image
        self.isLoading = isLoading
        self.showRetry = showRetry
    }
}
