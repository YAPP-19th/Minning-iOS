//
//  MonthGraphView.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class MonthGraphView: UIView {
    private let curvedLineChart: LineChart = LineChart()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        self.snp.makeConstraints { make in
            make.height.equalTo(216)
        }
        
        addSubview(curvedLineChart)
        curvedLineChart.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        curvedLineChart.dataEntries = generateRandomEntries()
        curvedLineChart.showDots = true
        curvedLineChart.isCurved = true
    }
    
    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        result.append(PointEntry(value: 70, label: "1주차"))
        result.append(PointEntry(value: 20, label: "2주차"))
        result.append(PointEntry(value: 80, label: "3주차"))
        result.append(PointEntry(value: 30, label: "4주차"))
        result.append(PointEntry(value: 60, label: "5주차"))
//        result.append(PointEntry(value: 10, label: "6주차"))
        return result
    }
}
