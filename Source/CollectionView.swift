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
    
    public func setNeedsReload() {
        needsReload = true;
        setNeedsLayout()
    }

}
