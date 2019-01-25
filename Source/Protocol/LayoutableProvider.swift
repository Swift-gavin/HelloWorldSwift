//
//  LayoutableProvider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol LayoutableProvider {
    var layout: Layout {get}
    var internalLayout: Layout {get}
    func layoutContext(collectionSize: CGSize) -> LayoutContext
}

extension LayoutableProvider where Self: Provider {
    public var internalLayout: Layout {
        return layout
    }
    public func layout(collectionSize: CGSize) {
        internalLayout.layout(context: layoutContext(collectionSize: contentSize))
    }
    public func visibleIndexes(visibleFrame: CGRect) -> [Int] {
        return internalLayout.visibleIndexes(visibleFrame: visibleFrame)
    }
    public func contentSize: CGSize {
        return internalLayout.contentSize
    }
    public func frame(at: Int) -> CGRect {
        return internalLayout.frame(at: at)
    }
}
