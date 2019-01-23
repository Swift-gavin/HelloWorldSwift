//
//  EmptyCollectionProvider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/23.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class EmptyCollectionProvider: ItemProvider, CollectionReloadable {
    open var identifier: String?
    
    public init(identifier: String? = nil) {
        self.identifier = identifier
    }
    open var numberOfItems: Int {
        return 0
    }
    
    open func view(at: Int) -> UIView {
        return UIView()
    }
    
    open func update(view: UIView, at: Int) {
        
    }
    
    open func identifier(at: Int) -> String {
        return "\(at)"
    }
    
    open var contentSize: CGSize {
        return .zero
    }
    
    open func layout(collectionSize: CGSize) {
        
    }
    
    open func frame(at: Int) -> CGRect {
        return .zero
    }
    
    open func visibleIndexes(visibleFrame: CGRect) -> [Int] {
        return [Int]()
    }
    
    open func animator(at: Int) -> Animator? {
        return nil
    }
    
    open func willReload() {
        
    }
    
    open func didReload() {
        
    }
    
    open func didTap(view: UIView, at: Int) {
        
    }
    
    open func hasReloadable(_ reloadable: CollectionReloadable) -> Bool {
        return reloadable === self
    }
}
