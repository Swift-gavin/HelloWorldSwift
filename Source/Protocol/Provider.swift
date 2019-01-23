//
//  Provider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol Provider {
    var identifier: String? {get}
    
    //data
    var numberOfItems: Int {get}
    func identifier(at: Int) -> String
    
    //layout
    func layout(collectionSize:CGSize)
    func visibleIndexes(visibleFrame: CGRect) -> [Int]
    var contentSize: CGSize {get}
    func frame(at: Int) -> CGRect
    
    //event
    func willReload()
    func didReload()
    
    
    func animator(at: Int) -> Animator?
    func hasReloadable(_ reloadable: CollectionReloadable) -> Bool
    
    func flattenedProvider() -> ItemProvider
    
}

extension Provider {
    public func willReload() {}
    public func didReload() {}
}
