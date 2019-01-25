//
//  SimpleAnimator.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class SimpleAnimator: Animator {
    open var animationDuration: TimeInterval = 0.3
    open var animationOptions: UIView.AnimationOptions = []
    open var useSpringAnimation: Bool = false
    open var springDamping: CGFloat = 0.8
    
    open func hide(view: UIView) {}
    open func show(view: UIView) {}
    
    open override func insert(collectionView: CollectionView, view: UIView, at: Int, frame: CGRect) {
        super.insert(collectionView: collectionView, view: view, at: at, frame: frame)
        if collectionView.isReloading, collectionView.hasReloaded, collectionView.bounds.intersects(frame) {
            hide(view: view)
//            ani
        }
    }
    
    open func animate(_ animations: @escaping () -> Void) {
        
    }
    
    open func animate(_ animations: @escaping () -> Void,
                      completion: ((Bool)-> Void)?) {
        if useSpringAnimation {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           usingSpringWithDamping: springDamping,
                           initialSpringVelocity: 0,
                           options: animationOptions,
                           animations: animations,
                           completion: completion)
        }
        else {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: animationOptions,
                           animations: animations,
                           completion: completion)
        }
    }
}
