//
//  ArrayDataSource.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/25.
//  Copyright © 2019 liu kai. All rights reserved.
//

import Foundation

public typealias IdentifierMapperFn<Data> = (Int, Data) -> String

open class ArrayDataSource<Data>: DataSource<Data> {
    
    open var data: [Data] {
        didSet {
            setNeedsReload()
        }
    }
    
    open var identifierMapper: IdentifierMapperFn<Data> {
        didSet {
            setNeedsReload()
        }
    }
    
    public init(data: [Data] = [], identifierMapper: @escaping IdentifierMapperFn<Data> = { index, _ in "\(index)"}) {
        self.data = data
        self.identifierMapper = identifierMapper
    }
    
    open override var numberOfItems: Int {
        return data.count
    }
    
    open override func identifier(at: Int) -> String {
        return identifierMapper(at, data[at])
    }
    
    open override func data(at: Int) -> Data {
        return data[at]
    }
}
