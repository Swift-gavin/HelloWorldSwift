//
//  CollectionView.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class CollectionView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public var provider: Provider? {
        didSet { setNeedsReload() }
    }
    
    public var animator: Animator = Animator() {
        didSet { setNeedsReload() }
    }
    
    public private(set) var reloadCount = 0
    public private(set) var needsReload = true
    public private(set) var needsInvalidateLayout = false
    public private(set) var isLoadingCell = false
    public private(set) var isReloading = false
    public var hasReloaded: Bool {return reloadCount > 0}
    
    public let tapGestureRecongnizer = UITapGestureRecognizer();
    
    public private(set) var visibleIndexes: [Int] = []
    public private(set) var visibleCells: [UIView] = []
    public private(set) var visibleIdentifiers: [String] = []
    
    public private(set) var lastLoadBounds: CGRect = .zero
    public private(set) var contentOffsetChange: CGPoint = .zero
    lazy var flattenedProvider: ItemProvider = EmptyCollectionProvider();
    var identifierCache: [Int: String] = [:]
    
    public func setNeedsReload() {
        needsReload = true;
        setNeedsLayout()
    }
    
    public func reloadData(contentOffsetAdjustFn: (()-> CGPoint)? = nil) {
        guard !isReloading else {
            return
        }
        provider?.willReload()
        flattenedProvider = (provider ?? EmptyCollectionProvider()).flattenedProvider()
        isReloading = true
        
        flattenedProvider.layout(collectionSize: innerSize);
        let oldContentOffset = contentOffset
        contentSize = flattenedProvider.contentSize
        if let offset = contentOffsetAdjustFn?() {
            contentOffset = offset
        }
        contentOffsetChange = contentOffset - oldContentOffset
        
        let oldVisibleCells = Set(visibleCells)
//        _load
        
    }
    
    private func _loadCells(forceReload: Bool) {
        let newIndexes = flattenedProvider.visibleIndexes(visibleFrame: visibleFrame)
        
        guard forceReload || newIndexes.last != visibleIndexes.last || newIndexes != visibleIndexes else {
            return;
        }
        
        if forceReload {
            identifierCache.removeAll()
        }
        
        var newIdentifierSet = Set<String>()
        let newIdentifiers:[String] = newIndexes.map { index in
            if let identifier = identifierCache[index] {
                newIdentifierSet.insert(identifier)
                return identifier
            }
            else {
//                let identifier = flattenedProvider.identifier(at)
            }
        }
    }


}
