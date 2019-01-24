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
    
    public convenience init(provider: Provider) {
        self.init()
        self.provider = provider
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        CollectionViewManager.shared.register(collectionView: self)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if needsReload {
            reloadData()
        }
        else if needsInvalidateLayout || bounds.size != lastLoadBounds.size {
            invalidateLayout()
        }
        else if bounds != lastLoadBounds {
            loadCells()
        }
    }
    
    public func setNeedsReload() {
        needsReload = true;
        setNeedsLayout()
    }
    
    public func setNeedsInvalidateLayout() {
        needsInvalidateLayout = true
        setNeedsLayout()
    }
    
    public func invalidateLayout() {
        guard !isLoadingCell && !isReloading && hasReloaded else {
            return
        }
        
        flattenedProvider.layout(collectionSize: innerSize)
        contentSize = flattenedProvider.contentSize
        needsInvalidateLayout = false
        loadCells()
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
        _loadCells(forceReload: true)
        
        for (cell, index) in zip(visibleCells, visibleIndexes) {
            cell.currentCollectionAnimator = cell.collectionAnimator ?? flattenedProvider.animator(at: index)
            let animator = cell.currentCollectionAnimator ?? self.animator
            if oldVisibleCells.contains(cell) {
                flattenedProvider.update(view: cell, at: index)
                animator.shift(collectionView: self, delta: contentOffsetChange, view: cell, at: index, frame: flattenedProvider.frame(at: index))
            }
            animator.update(collectionView: self, view: cell, at: index, frame: flattenedProvider.frame(at: index))
        }
        
        lastLoadBounds = bounds
        needsInvalidateLayout = false
        needsReload = false
        reloadCount += 1
        isReloading = false
        flattenedProvider.didReload()
    }
    
    func loadCells() {
        guard !isLoadingCell && !isReloading && hasReloaded else {
            return
        }
        isLoadingCell = true
        
        _loadCells(forceReload: false)
        
        for (cell, index) in zip(visibleCells, visibleIndexes) {
            let animator = cell.currentCollectionAnimator ?? self.animator
            animator.update(collectionView: self, view: cell, at: index, frame: flattenedProvider.frame(at: index))
        }
        
        lastLoadBounds = bounds
        isLoadingCell = false
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
                let identifier = flattenedProvider.identifier(at: index)
                
                var finialIdentifier = identifier
                var count = 1
                while newIdentifierSet.contains(finialIdentifier) {
                    finialIdentifier = identifier + "(\(count))"
                    count += 1
                }
                newIdentifierSet.insert(finialIdentifier)
                identifierCache[index] = finialIdentifier
                return finialIdentifier
            }
        }
        
        var existingIdentifierToCellMap: [String: UIView] = [:]
        
        for (index, identifier) in visibleIdentifiers.enumerated() {
            let cell = visibleCells[index]
            if !newIdentifierSet.contains(identifier) {
                (cell.currentCollectionAnimator ?? animator)?.delete(collectionView: self, view: cell)
            }
            else {
                existingIdentifierToCellMap[identifier] = cell
            }
        }
        
        let newCells: [UIView] = zip(newIdentifiers, newIndexes).map {identifier, index in
            if let existingCell = existingIdentifierToCellMap[identifier] {
                return existingCell
            }
            else {
                return _generateCell(index: index)
            }
        }
        
        visibleIndexes = newIndexes
        visibleIdentifiers = newIdentifiers
        visibleCells = newCells
    }
    
    private func _generateCell(index: Int) -> UIView {
        let cell = flattenedProvider.view(at: index)
        let frame = flattenedProvider.frame(at: index)
        cell.bounds.size = frame.bounds.size
        cell.center = frame.center
        cell.currentCollectionAnimator = cell.collectionAnimator ?? flattenedProvider.animator(at: index)
        let animator = cell.currentCollectionAnimator ?? self.animator
        animator.insert(collectionView: self, view: cell, at: index, frame: flattenedProvider.frame(at: index))
        return cell
    }
}

extension CollectionView {
    public func indexForCell(at point:CGPoint) -> Int? {
        for (index, cell) in zip(visibleIndexes, visibleCells) {
            if cell.point(inside: cell.convert(point, from: self), with: nil) {
                return index
            }
        }
        return nil
    }
    
    public func index(for cell: UIView) ->Int? {
        if let position = visibleCells.index(of: cell) {
            return visibleIndexes[position]
        }
        return nil
    }
    
    public func cell(at index: Int) -> UIView? {
        if let position = visibleIndexes.index(of: index) {
            return visibleCells[position]
        }
        return nil
    }
}
