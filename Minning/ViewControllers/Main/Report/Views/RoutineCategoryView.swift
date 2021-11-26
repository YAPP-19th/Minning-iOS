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
    public var isAll: Bool = false
    public var category: RoutineCategory = .miracle
    
    public override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .blue67A4FF : .minningLightGray100
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
        }
    }
    
    private let sectionTitle: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "카테고리별 비교"
        return $0
    }(UILabel())
    
    private let categoryContianerView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
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
    
    private let minningImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "minning_icon")
        return $0
    }(UIImageView())

    private let separator: UIView = {
        $0.backgroundColor = .primaryLightGray
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
        $0.spacing = 8
        $0.alignment = .leading
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIStackView())
    
    private let selectedCategoryInfoView: UIView = {
        $0.backgroundColor = .minningBlue20
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private lazy var selectedCategoryLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .minningDarkGray100
        if let currentRoutine = routineData.first {
            let targetString = "\(Int(currentRoutine.percent))%"
            let fullText = "전체 중 \(targetString)를 차지하고 있어요"
            
            let range = (fullText as NSString).range(of: targetString)
            let valueAttrString = NSMutableAttributedString(string: fullText)
            valueAttrString.addAttributes([.font: UIFont.font20PBold,
                                           .foregroundColor: UIColor.minningBlue100,
                                           .baselineOffset: 0], range: range)
            $0.attributedText = valueAttrString
        }
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPieData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        [sectionTitle, categoryContianerView,
         separator,
         filterScrollView,
         selectedCategoryInfoView].forEach {
            addSubview($0)
        }
        [categoryLegendStackView, halfPieChart, minningImageView].forEach {
            categoryContianerView.addSubview($0)
        }
        
        filterScrollView.addSubview(filterContainerView)
        filterContainerView.addSubview(tableFilterStackView)
        selectedCategoryInfoView.addSubview(selectedCategoryLabel)

        setupFilterview()
        
        separator.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
        }
        
        sectionTitle.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        categoryContianerView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        categoryLegendStackView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        halfPieChart.snp.makeConstraints { make in
            make.top.equalTo(categoryLegendStackView.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(48)
//            make.trailing.equalToSuperview().offset(-48)
            make.width.equalTo(280)
            make.centerX.equalToSuperview()
            make.height.equalTo(halfPieChart.snp.width).multipliedBy(0.5 / 1.0)
            make.bottom.equalTo(-26)
        }
        
        minningImageView.snp.makeConstraints { make in
            make.width.equalTo(82)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-26)
        }

        filterScrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryContianerView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33)
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
//            make.width.equalToSuperview().priority(250)
        }
        
        tableFilterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectedCategoryInfoView.snp.makeConstraints { make in
            make.top.equalTo(filterScrollView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-20)
            make.height.equalTo(70)
        }
        
        selectedCategoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    
    private func updateFilterView() {
        tableFilterStackView.arrangedSubviews.enumerated().forEach { index, subView in
            if let filterButton = subView as? FilterButton {
                filterButton.isSelected = (currentCategory == routineData[index - 1].category)
            }
        }
    }
    
    private func updateSelectedCategoryLabel(with routine: ReportRoutine) {
        let targetString = "\(Int(routine.percent))%"
        let fullText = "전체 중 \(targetString)를 차지하고 있어요"
        
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font20PBold,
                                       .foregroundColor: UIColor.minningBlue100,
                                       .baselineOffset: 0], range: range)
        selectedCategoryLabel.attributedText = valueAttrString
    }
    
    @objc
    private func onClickFilterButton(_ sender: FilterButton) {
        currentCategory = sender.category
        updateFilterView()
        updateSelectedCategoryLabel(with: routineData[currentCategory.rawValue])
    }
}
