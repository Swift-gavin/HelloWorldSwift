//
//  CollectionReuseViewManager.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/24.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol CollectionViewReusableView: class {
    func prepareForReuse()
}

public class CollectionReuseViewManager: NSObject {
    public var lifeSpan: TimeInterval = 5.0
    
    public var removeFromCollectionViewWhenReuse = false
    
    var reusableViews: [String: [UIView]] = [:]
    var cleanupTimer: Timer?
    
    public func queue(view: UIView) {
        let identifier = NSStringFromClass(type(of: view))
        view.reuseManager = nil
        if removeFromCollectionViewWhenReuse {
            view.removeFromSuperview()
        }
        else {
            view.isHidden = true
        }
        
        if reusableViews[identifier] != nil && !reusableViews[identifier]!.contains(view) {
            reusableViews[identifier]?.append(view)
        }
        else {
            reusableViews[identifier] = [view]
        }
        
        if let cleanupTimer = cleanupTimer {
            cleanupTimer.fireDate = Date().addingTimeInterval(lifeSpan)
        }
        else {
            cleanupTimer = Timer.scheduledTimer(timeInterval: lifeSpan, target: self, selector: #selector(cleanup), userInfo: nil, repeats: false)
        }
    }
    
    @objc func cleanup() {
        for views in reusableViews.values {
            for view in views {
                view.removeFromSuperview()
            }
        }
        reusableViews.removeAll()
        cleanupTimer?.invalidate()
        cleanupTimer = nil
    }
}
