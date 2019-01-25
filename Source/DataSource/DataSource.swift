//
//  DataSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import Foundation

open class DataSource<Data>: CollectionReloadable {
    open var numberOfItems: Int {
        return 0
    }
    
    open func data(at: Int) -> Data {
        fatalError()
    }
    open func identifier(at: Int) -> String {
        return "\(at)"
    }
    public init() {}
//    public init(getter: @escaping () -> [Data],
//                identifierMapper: @escaping IdentifierMapperFn<Data> = { index, _ in "\(index)"}) {
//        self.getter = getter
//
//    }
}
