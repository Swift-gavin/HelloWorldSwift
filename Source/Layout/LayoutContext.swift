//
//  LayoutContext.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol LayoutContext {
    var collectionSize: CGSize {get}
    var numberOfItems: Int {get}
    func data(at: Int) -> Any
    func identifier(at: Int) -> String
    func size(at index: Int, collectionSize: CGSize) -> CGSize
}
