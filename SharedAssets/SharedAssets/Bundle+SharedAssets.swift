//
//  Bundle+SharedAssets.swift
//  SharedAssets
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {
    class var sharedAssets: Bundle {
        return Bundle(identifier: "com.denny.SharedAssets")!
    }
}

public extension UIImage {
    convenience init?(sharedNamed: String) {
        self.init(named: sharedNamed, in: Bundle.sharedAssets, compatibleWith: nil)
    }
}

public extension String {
    var templateImageShared: UIImage? {
        return UIImage(named: self, in: Bundle.sharedAssets, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

    var namedImageShared: UIImage? {
        return UIImage(named: self, in: .sharedAssets, compatibleWith: nil)
    }
}
