//
//  RoutineCategoryView.swift
//  Minning
//
//  Created by denny on 2021/10/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem

final class RoutineCategoryView: UIView {
    public var routineData: [ReportRoutine] = [] {
        didSet {
            var pieChartData: [PieChartData] = []
            routineData.forEach {
                pieChartData.append(PieChartData(value: $0.percent, color: $0.category.color))
            }
            
            halfPieChart.dataSet = pieChartData
        }
    }
    
    private let sectionTitle: UILabel = {
        $0.font = .font12PBold
        $0.textColor = .minningDarkGray100
        $0.text = "카테고리별 비교"
        return $0
    }(UILabel())
    
    lazy var halfPieChart: HalfPieChart = {
        $0.backgroundColor = .clear
        $0.pieTouchHandler = { index in
            DebugLog("Selected Index: \(RoutineCategory(rawValue: index)?.title)")
        }
        return $0
    }(HalfPieChart())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupPieData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        [sectionTitle, halfPieChart].forEach {
            addSubview($0)
        }
        
        sectionTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        halfPieChart.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo(halfPieChart.snp.width).multipliedBy(0.5 / 1.0)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupPieData() {
        let sampleRoutineReportData: [ReportRoutine] = [
            ReportRoutine(category: .miracle, percent: 33),
            ReportRoutine(category: .selfDev, percent: 20),
            ReportRoutine(category: .health, percent: 10),
            ReportRoutine(category: .life, percent: 26),
            ReportRoutine(category: .other, percent: 11)
        ]
        
        routineData = sampleRoutineReportData
    }
}
