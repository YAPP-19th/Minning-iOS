//
//  RoutineCategoryView.swift
//  Minning
//
//  Created by denny on 2021/10/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem

final class FilterButton: UIButton {
    public var category: RoutineCategory = .miracle
    
    public override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .blue67A4FF : .primaryWhite
            setTitleColor(isSelected ? .primaryWhite : .gray787C84, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        contentEdgeInsets = UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)
        titleLabel?.font = .font16P
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
            currentCategory = .miracle
        }
    }
    
    private var currentCategory: RoutineCategory = .miracle {
        didSet {
            updateFilterView()
            updateCategoryDataView(reportRoutine: routineData[currentCategory.rawValue])
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
            self.currentCategory = RoutineCategory(rawValue: index) ?? .miracle
//            self.updateCategoryDataView(reportRoutine: self.routineData[index])
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
    
    private let filterScrollView: UIScrollView = {
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView())
    
    private let filterContainerView: UIView = UIView()
    private let tableFilterStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .leading
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIStackView())
    
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
        [sectionTitle, categoryLegendStackView,
         halfPieChart, dataContainerView, separator,
         filterScrollView].forEach {
            addSubview($0)
        }
        
        filterScrollView.addSubview(filterContainerView)
        filterContainerView.addSubview(tableFilterStackView)
        
        [categoryTitleLabel, categoryValueLabel].forEach {
            dataContainerView.addSubview($0)
        }
        
        setupFilterview()
        
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
//            make.leading.equalToSuperview().offset(48)
//            make.trailing.equalToSuperview().offset(-48)
            make.width.equalTo(280)
            make.centerX.equalToSuperview()
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
        }
        
        filterScrollView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
        
        tableFilterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    
    private func setupFilterview() {
        let leadingSpacer = UIView()
        let trailingSpacer = UIView()
        [leadingSpacer, trailingSpacer].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(16)
            }
        }
        
        tableFilterStackView.addArrangedSubview(leadingSpacer)
        tableFilterStackView.setCustomSpacing(0, after: leadingSpacer)
        RoutineCategory.allCases.enumerated().forEach { index, category in
            let legendView = PieLegendView()
            legendView.title = category.title
            legendView.circleColor = category.color
            categoryLegendStackView.addArrangedSubview(legendView)
            
            let filterButton = FilterButton()
            filterButton.isSelected = currentCategory == category
            filterButton.category = category
            filterButton.setTitle(category.title, for: .normal)
            filterButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
            tableFilterStackView.addArrangedSubview(filterButton)
            
            if index == RoutineCategory.allCases.count - 1 {
                tableFilterStackView.addArrangedSubview(trailingSpacer)
                tableFilterStackView.setCustomSpacing(0, after: filterButton)
            }
        }
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
    
    private func updateFilterView() {
        tableFilterStackView.arrangedSubviews.enumerated().forEach { index, subView in
            if let filterButton = subView as? FilterButton {
                filterButton.isSelected = (currentCategory == routineData[index - 1].category)
            }
        }
    }
    
    @objc
    private func onClickFilterButton(_ sender: FilterButton) {
        currentCategory = sender.category
        updateFilterView()
    }
}
