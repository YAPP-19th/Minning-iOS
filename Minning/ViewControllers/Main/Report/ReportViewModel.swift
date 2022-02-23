//
//  ReportViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class ReportViewModel {
    enum ReportTabType {
        case week
        case month
    }
    
    var tabType: DataBinding<ReportTabType> = DataBinding(.week)
    private let coordinator: MainCoordinator
    
    var monthList: [Int] = []
    var selectedMonth: Int?
    
    var datePickerList: [(Date, Date)] = []
    var selectedWeek: (Date, Date)?
    
    public init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        generateMonthList()
    }
    
    private func generateMonthList() {
        let todayDate = Date()
        let todayMonth = todayDate.get(.month)
        
        monthList.removeAll()
        for month in 1..<(todayMonth + 1) {
            monthList.append(month)
        }
    }
    
    public func getWeeklyReportData() {
        
    }
    
    public func getMonthlyReportData() {
        
    }
}
