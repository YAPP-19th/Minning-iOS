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
    private let chartContainerView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.text = "주별 달성률 비교"
        $0.textColor = .primaryBlack
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
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
            make.height.equalTo(300)
        }
        
        [titleLabel, chartContainerView].forEach {
            addSubview($0)
        }
        chartContainerView.addSubview(curvedLineChart)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        chartContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-20)
            make.height.equalTo(220)
        }
        curvedLineChart.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.bottom.equalTo(-23)
            make.leading.trailing.equalToSuperview()
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
