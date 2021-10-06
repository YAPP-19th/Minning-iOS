//
//  DataBinding.swift
//  CommonSystem
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

public class DataBinding<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?

    public func bind(_ listener: Listener?) {
        self.listener = listener
    }

    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    public private(set) var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ val: T) {
        value = val
    }
    
    public func accept(_ val: T) {
        value = val
    }
}
