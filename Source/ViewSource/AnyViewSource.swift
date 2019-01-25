//
//  AnyViewSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol AnyViewSource {
    func anyView(data: Any, index: Int) -> UIView
    func anyUpdate(view: UIView, data: Any, index: Int)
}
