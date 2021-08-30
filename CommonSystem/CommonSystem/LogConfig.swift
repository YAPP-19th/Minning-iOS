//
//  LogConfig.swift
//  CommonSystem
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
public func DebugLog(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    print("🗣 [\(getCurrentTime())] \(function) - \(message())")
}

// swiftlint:disable identifier_name
public func ErrorLog(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    print("⚡️ [\(getCurrentTime())] \(function) - \(message())")
}

// swiftlint:disable identifier_name
public func WarningLog(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    let logMessageWithCallStack = message() + "\n--------------\n" + Thread.callStackSymbols.joined(separator: "\n")
    print("🚨 [\(getCurrentTime())] \(function) - \(logMessageWithCallStack)")
}

private func getCurrentTime() -> String {
    let now = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return dateFormatter.string(from: now as Date)
}
