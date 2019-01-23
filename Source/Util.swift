//
//  Util.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

extension Collection {
    func binarySearch(predicate: (Iterator.Element) -> Bool) -> Index {
        var low = startIndex
        var high = endIndex
        while low != high {
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            if  predicate(self[mid]) {
                low = index(after: mid)
            }
            else {
                high = mid
            }
        }
        return low
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY);
    }
    var bounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }
    
    func - (left: CGPoint,right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x,  y: left.y - right.y)
    }
    
    func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }
}
