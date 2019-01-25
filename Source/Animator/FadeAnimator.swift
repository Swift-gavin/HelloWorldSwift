//
//  FadeAnimator.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class FadeAnimator: SimpleAnimator {
    open var alpha: CGFloat = 0
    
    open override func hide(view: UIView) {
        view.alpha = alpha
    }
    
    open override func show(view: UIView) {
        view.alpha = 1
    }
}
