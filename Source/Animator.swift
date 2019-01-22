//
//  Animator.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class Animator {
    open func insert(collectionView: CollectionView,
                     view: UIView,
                     at: Int,
                     frame: CGRect){
        view.bounds.size = frame.bounds.size
        view.center = frame.center
    }
    public init() {}
}
