//
//  Date+Extensions.swift
//  CommonSystem
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public extension Date {
    func dateTypeToString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
    func dateTypeToKoreanString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "MM월 dd일"
        
        return formatter.string(from: self)
    }
    
    func dateTypeToKoreanDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.date(from: self.dateTypeToString())
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    static func createDate(year: Int, month: Int, day: Int,
                           hour: Int = 0, minute: Int = 0, seconds: Int = 0) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "\(year)-\(month)-\(day)")
    }
    
    func weeklyDateList() -> [(Date, Date)] {
        var result: [(Date, Date)] = []
        
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        if let startDayOfMonth = Calendar.current.date(from: components),
           let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: startDayOfMonth),
           let endOfMonth = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth) {
            let startDayIndex = Calendar.current.component(.weekday, from: startDayOfMonth)
            let firstWeekStartDay = Date(timeInterval: -(Double(86400 * ((startDayIndex + 5) % 7))), since: startDayOfMonth)
            
            var weekStartDay: Date
            var weekEndDay: Date
            
            // MARK: Week 1
            if !(startDayOfMonth == firstWeekStartDay) {
                weekStartDay = startDayOfMonth
            } else {
                weekStartDay = firstWeekStartDay
            }
            
            weekEndDay = Calendar.current.date(byAdding: .day, value: 6 - (Calendar.current.component(.weekday, from: weekStartDay) + 5) % 7, to: weekStartDay)!
            result.append((weekStartDay, weekEndDay))
            
            var nextWeekStartDay: Date = firstWeekStartDay
            for _ in 0..<6 {
                nextWeekStartDay = Date(timeInterval: 86400 * 7, since: nextWeekStartDay)
                if nextWeekStartDay <= endOfMonth {
                    DebugLog("nextWeek WeekOfMonth: \(Calendar.current.component(.weekOfMonth, from: nextWeekStartDay))")
                    DebugLog("nextWeekStartday: \(nextWeekStartDay)")
                    
                    weekEndDay = Calendar.current.date(byAdding: .day, value: 6 - (Calendar.current.component(.weekday, from: nextWeekStartDay) + 5) % 7, to: nextWeekStartDay)!
                    result.append((nextWeekStartDay, weekEndDay))
                }
            }
        }
        
        DebugLog("Result: \(result.debugDescription)")
        return result
    }
    
    func convertToCustomString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallDotString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToKoreanString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallKoreanString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
