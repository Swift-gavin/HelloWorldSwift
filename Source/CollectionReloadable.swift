//
//  CollectionReloadable.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/22.
//  Copyright © 2019 liu kai. All rights reserved.
//

import UIKit

public protocol CollectionReloadable: class {
    var collectionView: CollectionView? {get}
}
