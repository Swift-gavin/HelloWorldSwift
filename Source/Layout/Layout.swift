//
//  Layout.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class Layout {
    
    open func layout(context: LayoutContext) {
        fatalError("Subclass should provide its own layout")
    }
    
    open var contentSize: CGSize {
        fatalError("Subclass should provide its own layout")
    }
    
    open func frame(at:Int) -> CGRect {
        fatalError("Subclass should provide its own layout")
    }
    
    open func visibleIndexes(visibleFrame: CGRect) -> [Int] {
        fatalError("Subclass should provide its own layout")
    }
    
    public init() {}
}

extension Layout {
//    public func transposed() -> TransposeLayout {
//        
//    }
}
