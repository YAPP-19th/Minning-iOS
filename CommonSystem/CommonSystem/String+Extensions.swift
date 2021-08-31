//
//  String+Extensions.swift
//  CommonSystem
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

public extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date: Date = dateFormatter.date(from: self) ?? Date()
        return date
    }

    func convertToSmallDate() -> Date {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date: Date = dateFormatter.date(from: self)!
        return date
    }
}
