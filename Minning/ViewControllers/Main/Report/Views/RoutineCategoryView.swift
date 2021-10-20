//
//  RoutineCategoryView.swift
//  Minning
//
//  Created by denny on 2021/10/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem

final class PieLegendView: UIView {
    public var category: RoutineCategory = .miracle {
        didSet {
            circleView.backgroundColor = category.color
            titleLabel.text = category.title
        }
    }
    
    private let circleView: UIView = {
        $0.layer.cornerRadius = 7
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .gray787C84
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
        [circleView, titleLabel].forEach {
            addSubview($0)
        }
        
        circleView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(circleView.snp.trailing).offset(4)
        }
    }
}

final class RoutineCategoryView: UIView {
    public var routineData: [ReportRoutine] = [] {
        didSet {
            var pieChartData: [PieChartData] = []
            routineData.forEach {
                pieChartData.append(PieChartData(value: $0.percent, color: $0.category.color))
            }
            
            halfPieChart.dataSet = pieChartData
            
            if let data = routineData.first {
                updateCategoryDataView(reportRoutine: data)
            }
        }
    }
    
    private let sectionTitle: UILabel = {
        $0.font = .font12PBold
        $0.textColor = .minningDarkGray100
        $0.text = "카테고리별 비교"
        return $0
    }(UILabel())
    
    private let categoryLegendStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    lazy var halfPieChart: HalfPieChart = {
        $0.backgroundColor = .clear
        $0.pieTouchHandler = { index in
            DebugLog("Selected Index: \(RoutineCategory(rawValue: index)?.title ?? "nil")")
            self.updateCategoryDataView(reportRoutine: self.routineData[index])
        }
        return $0
    }(HalfPieChart())
    
    private let dataContainerView: UIView = {
        $0.backgroundColor = .grayF6F7F9
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private let categoryTitleLabel: UILabel = {
        $0.font = .font14PBold
        $0.textColor = .gray787C84
        $0.numberOfLines = 1
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private let categoryValueLabel: UILabel = {
        $0.font = .font14P
        $0.textColor = .gray787C84
        $0.numberOfLines = 1
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private let separator: UIView = {
        $0.backgroundColor = .grayEDEDED
        return $0
    }(UIView())
    
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
        [sectionTitle, categoryLegendStackView, halfPieChart, separator, dataContainerView].forEach {
            addSubview($0)
        }
        
        [categoryTitleLabel, categoryValueLabel].forEach {
            dataContainerView.addSubview($0)
        }
        
        RoutineCategory.allCases.forEach { category in
            let legendView = PieLegendView()
            legendView.category = category
            categoryLegendStackView.addArrangedSubview(legendView)
        }
        
        sectionTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        categoryLegendStackView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom).offset(21)
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        halfPieChart.snp.makeConstraints { make in
            make.top.equalTo(categoryLegendStackView.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo(halfPieChart.snp.width).multipliedBy(0.5 / 1.0)
        }
        
        dataContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(halfPieChart.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.centerX.equalToSuperview()
        }
        
        categoryValueLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(halfPieChart.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(1)
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
    
    private func updateCategoryDataView(reportRoutine: ReportRoutine) {
        categoryTitleLabel.text = reportRoutine.category.title
        
        let targetString = "\(Int(reportRoutine.percent))%"
        let fullText = "전체 중 \(targetString)"
        
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font20PBold,
                                       .foregroundColor: UIColor.blue67A4FF,
                                       .baselineOffset: -1.5], range: range)
        categoryValueLabel.attributedText = valueAttrString
    }
}
