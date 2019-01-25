//
//  WrapperLayout.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class WarpperLayout: Layout {
    var rootLayout: Layout
    
    public init(_ rootLayout: Layout) {
        self.rootLayout = rootLayout
    }
    
    open override var contentSize: CGSize {
        return rootLayout.contentSize
    }
    
    open override func layout(context: LayoutContext) {
        rootLayout.layout(context: context)
    }
    
    open override func visibleIndexes(visibleFrame: CGRect) -> [Int] {
        return rootLayout.visibleIndexes(visibleFrame: visibleFrame)
    }
    
    open override func frame(at: Int) -> CGRect {
        return rootLayout.frame(at: at)
    }
}
