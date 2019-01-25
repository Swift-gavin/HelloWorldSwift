//
//  ViewSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

open class ViewSource<Data, View: UIView> {
    public private(set) lazy var reuseManager = CollectionReuseViewManager()
    
    open func view(data: Data, index: Int) -> View {
        let view = reuseManager.dequeue(View())
        update(view: view, data: data, index: index)
        return view
    }
    
    open func update(view: View, data: Data, index:Int) {}
    
    public init() {}
}

extension ViewSource: AnyViewSource {
    public final func anyView(data: Any, index: Int) -> UIView {
        return view(data: data as! Data, index: index)
    }
    
    public final func anyUpdate(view: UIView, data: Any, index: Int) {
        return update(view: view as! View, data: data as! Data, index: index)
    }
}
