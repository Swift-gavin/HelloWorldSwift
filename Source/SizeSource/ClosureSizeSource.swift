//
//  ClosureSizeSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public typealias ClosureSizeSourceFn<Data> = (Int, Data, CGSize) -> CGSize

open class ClosureSizeSource<Data>: SizeSource<Data> {
    open var sizeSource: ClosureSizeSourceFn<Data>
    
    public init(sizeSource: @escaping ClosureSizeSourceFn<Data>) {
        self.sizeSource = sizeSource
        super.init()
    }
    
    open override func size(at index: Int, data: Data, collectionSize: CGSize) -> CGSize {
        return sizeSource(index, data, collectionSize)
    }
}
