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
    
    var reportMonthModel: DataBinding<ReportMonthModel?> = DataBinding(nil)
    var reportWeekModel: DataBinding<ReportWeekModel?> = DataBinding(nil) // TODO
    
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
        
        selectedMonth = monthList.first
    }
    
    public func getMonthlyReportData() {
        if let selectedMonth = selectedMonth {
            ReportAPIRequest.monthlyReport(year: Date().get(.year), month: selectedMonth, completion: { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let model):
                    self.reportMonthModel.accept(model.data)
                case .failure(let error):
                    ErrorLog("\(error.status), \(error.msg)")
                    self.reportMonthModel.accept(nil)
//                    ErrorLog(error.defaultError.localizedDescription)
                }
            })
        }
    }
    
    public func getWeeklyReportData() {
        if let selectedWeek = selectedWeek {
            // year-month-day: ex 2022-02-22
            let month = selectedWeek.1.get(.month) < 10 ? "0\(selectedWeek.1.get(.month))" : "\(selectedWeek.1.get(.month))"
            let day = selectedWeek.1.get(.day) < 10 ? "0\(selectedWeek.1.get(.day))" : "\(selectedWeek.1.get(.day))"
            
            let lastDateString = "\(selectedWeek.1.get(.year))-\(month)-\(day)"
            ReportAPIRequest.weeklyReport(lastDate: lastDateString, completion: { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let model):
                    self.reportWeekModel.accept(model.data)
                case .failure(let error):
                    ErrorLog("\(error.status), \(error.msg)")
                    self.reportWeekModel.accept(nil)
                }
            })
        }
    }
}
