//
//  FlattenedProvider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/23.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

struct FlattenedProvider: ItemProvider {
    var provider: SectionProvider
    
    private var childSections: [(beginIndex: Int, sectionData: ItemProvider?)]
    
    init(provider: SectionProvider) {
        self.provider = provider
        var childSections: [(beginIndex: Int, sectionData: ItemProvider?)] = []
        var count = 0
        for i in 0..<provider.numberOfItems {
            let sectionData: ItemProvider?
            if let section = provider.section(at: i) {
                sectionData = section.flattenedProvider()
            }
            else {
                sectionData = nil
            }
            childSections.append((beginIndex: count, sectionData: sectionData))
            count += sectionData?.numberOfItems ?? 1
        }
        self.childSections = childSections
    }
    
    func indexPath(_ index:Int) -> (Int, Int) {
        let sectionIndex = self.childSections.binarySearch { $0.beginIndex <= index} - 1
        return (sectionIndex, index - childSections[sectionIndex].beginIndex)
    }
    
    func apply<T>(_ index: Int, with: (ItemProvider, Int) -> T) -> T {
        let (sectionIndex, item) = indexPath(index)
        if let sectionData = childSections[sectionIndex].sectionData {
            return with(sectionData, item)
        }
        else {
            assert(provider is ItemProvider, "provider don't support view index")
            return with(provider as! ItemProvider, sectionIndex)
        }
    }
    
    var identifier: String? {
        return provider.identifier
    }
    
    var numberOfItems: Int {
        return (childSections.last?.beginIndex ?? 0) + (childSections.last?.sectionData?.numberOfItems ?? 0)
    }
    
    func view(at: Int) -> UIView {
        return apply(at){
            $0.view(at: $1)
        }
    }
    
    func update(view: UIView, at: Int) {
        return apply(at){
            $0.update(view: view, at: $1)
        }
    }
    
    func identifier(at: Int) -> String {
        let (sectionIndex, item) = indexPath(at)
        if let sectionData = childSections[sectionIndex].sectionData {
            return provider.identifier(at: sectionIndex) + sectionData.identifier(at: item)
        }
        else {
            return provider.identifier(at: sectionIndex)
        }
    }
    
    func layout(collectionSize: CGSize) {
        provider.layout(collectionSize: contentSize)
    }
    
    var contentSize: CGSize {
        return provider.contentSize
    }
    
    func visibleIndexes(visibleFrame: CGRect) -> [Int] {
        var visible = [Int]()
        //todolist
        return visible
    }
    
    func frame(at: Int) -> CGRect {
        let (sectionIndex, item) = indexPath(at)
        if let sectionData = childSections[sectionIndex].sectionData {
            var frame = sectionData.frame(at: item)
            frame.origin += provider.frame(at: sectionIndex).origin
            return frame
        }
        else {
            return provider.frame(at:sectionIndex)
        }
    }
}
