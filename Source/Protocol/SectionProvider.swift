//
//  SectionProvider.swift
//  HelloWorldSwift
//
//  Created by liu kai on 2019/1/23.
//  Copyright © 2019 liu kai. All rights reserved.
//

import Foundation

public protocol SectionProvider: Provider {
    func section(at: Int) -> Provider?
}

extension SectionProvider {
    public func flattenedProvider() -> ItemProvider {
        return FlattenedProvider(provider: self)
    }
}
