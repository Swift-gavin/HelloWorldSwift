//
//  ScaleAnimator.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class ScaleAnimator: FadeAnimator {
    open var scale: CGFloat = 0.5
    
    open override func hide(view: UIView) {
        super.hide(view: view)
        view.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
    }
    
    open override func show(view: UIView) {
        super.show(view: view)
        view.transform = CGAffineTransform.identity
    }
}
