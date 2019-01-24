//
//  ItemProvider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol ItemProvider: Provider {
    func view(at: Int) -> UIView
    func update(view: UIView, at: Int)
    
    func didTap(view: UIView, at: Int)
}

extension ItemProvider {
    public func flattenedProvider() -> ItemProvider {
        return self;
    }
}
