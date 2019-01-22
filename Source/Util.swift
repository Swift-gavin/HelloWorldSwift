//
//  Util.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY);
    }
    var bounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }
}
