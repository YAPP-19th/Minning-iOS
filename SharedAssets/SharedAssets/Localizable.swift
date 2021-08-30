//
//  Localizable.swift
//  SharedAssets
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

public extension String {
    var sharedLocalized: String {
        if self.hasPrefix("Localized") {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.sharedAssets, comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    func sharedLocalized(comment: String) -> String {
        if self.hasPrefix("Localized") {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.sharedAssets, comment: comment)
        } else {
            return NSLocalizedString(self, comment: comment)
        }
    }
}
