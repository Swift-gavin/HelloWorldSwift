//
//  UIScrollView+CollectionKit.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/23.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

extension UIScrollView {
    public var visibleFrame: CGRect {
        return bounds;
    }
    
    public var absoluteFrameLessInset: CGRect {
        return CGRect(origin: .zero, size: bounds.size).inset(by: contentInset);
    }
    
    public var innerSize: CGSize {
        return absoluteFrameLessInset.size;
    }
}
