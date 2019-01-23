//
//  CollectionReloadable.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol CollectionReloadable: class {
    var collectionView: CollectionView? {get}
    func reloadData()
    func setNeedsReload()
}

extension CollectionReloadable {
    public var collectionView: CollectionView? {
        return CollectionViewManager.shared.collectionView(for: self);
    }
   
    public func reloadData() {
//        collectionView?.reloadData()
    }
    
    public func setNeedsReload(){
        
    }
}

internal class CollectionViewManager {
    static let shared: CollectionViewManager = {
//        CollectionView.swi
        //todolist
        return CollectionViewManager()
    }()
    
    var collectionViews = NSHashTable<CollectionView>.weakObjects()
    
    func collectionView(for reloadable: CollectionReloadable) -> CollectionView? {
        for collectionView in collectionViews.allObjects {
            if let provider = collectionView.provider, provider.hasReloadable(reloadable) {
                return collectionView
            }
        }
        return nil
    }
    
}

extension UIScrollView {
//    @objc func collectionKitAdjustContentOffsetIfNecessary(_ animated: Bool) {
//        guard !(self is CollectionView) ||!isDragging && !isDecelerating
//    }
    
    static func swizzleAdjustContentOffset() {
        let encoded = String("==QeyF2czV2Yl5kZJRXZzZmZPRnblRnbvNEdzVnakF2X".reversed())
        let originalMethodName = String(data: Data(base64Encoded: encoded)!, encoding: .utf8)!
        let originalSelector = NSSelectorFromString(originalMethodName);
//        let swizzledSelctor = #selector(CollectionView.coll)
    }
}
