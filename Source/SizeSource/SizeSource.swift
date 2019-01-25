//
//  SizeSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class SizeSource<Data> {
    public init() {}
    
    open func size(at index: Int, data: Data, collectionSize: CGSize) -> CGSize {
        return collectionSize
    }
    
}
