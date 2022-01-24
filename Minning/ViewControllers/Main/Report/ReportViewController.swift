//
//  ReportViewController.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ReportViewController: BaseViewController {
    private let weekTabButton: UIButton = {
        $0.setTitle("주", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let monthTabButton: UIButton = {
        $0.setTitle("월", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let dataComboButton: ComboButton = {
        $0.comboContent = "9월 0일 - 9월 00일"
        $0.addTarget(self, action: #selector(onClickComboButton(_:)), for: .touchUpInside)
        return $0
    }(ComboButton())
    
    private let percentGuideButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "questionButton.png"), for: .normal)
        $0.addTarget(self, action: #selector(onClickPercentGuideButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let scrollView: UIScrollView = {
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = UIView()
    private let contentStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private let bubbleView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        $0.isHidden = true
        return $0
    }(UIView())
    
    private let bubbleTriagleView: UIImageView = {
        $0.image = UIImage(sharedNamed: "bubble_triangle_report")
        $0.isHidden = true
        return $0
    }(UIImageView())
    
    private lazy var bubbleLabel: UILabel = {
        $0.text = viewModel.tabType.value == .week ? "매주 수요일마다 주 리포트가 갱신됩니다" : "매월 첫째주에 월 리포트가 갱신됩니다"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    private let reportArriveVC = ReportArriveViewController()
    
    // MARK: Report Content View
    private let myRoutineView: MyRoutineView = MyRoutineView()
    private let monthGraphView: MonthGraphView = MonthGraphView()
    private let weeklyPercentView: WeeklyPercentView = WeeklyPercentView()
    private let routineCategoryView: RoutineCategoryView = RoutineCategoryView()
    
    private let viewModel: ReportViewModel
    
    @objc
    private func onClickTabButton(_ sender: UIButton) {
        switch sender {
        case weekTabButton:
            viewModel.tabType.accept(.week)
        case monthTabButton:
            viewModel.tabType.accept(.month)
        default:
            break
        }
    }
    
    public init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setupViewLayout() {
        WarningLog("매주 수요일마다 reportArriveVC present 하는 조건 추가하기")
        present(reportArriveVC, animated: true, completion: nil)
        
        view.backgroundColor = .primaryWhite
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBackground(_:))))
        
        [weekTabButton, monthTabButton,
         dataComboButton, percentGuideButton, scrollView, bubbleTriagleView, bubbleView].forEach {
            view.addSubview($0)
        }
        
        weekTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        monthTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalTo(weekTabButton.snp.trailing)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        dataComboButton.snp.makeConstraints { make in
            make.top.equalTo(weekTabButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
        }
        
        percentGuideButton.snp.makeConstraints { make in
            make.centerY.equalTo(dataComboButton)
            make.trailing.equalToSuperview().offset(-8)
            make.width.height.equalTo(44)
        }
        
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dataComboButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [weeklyPercentView, myRoutineView,
         monthGraphView, routineCategoryView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        bubbleTriagleView.snp.makeConstraints { make in
            make.top.equalTo(percentGuideButton.snp.bottom).offset(-13)
            make.trailing.equalToSuperview().offset(-28.62)
            make.width.equalTo(20.32)
            make.height.equalTo(16.14)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(bubbleTriagleView.snp.bottom).offset(-1)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(50)
        }
        
        bubbleView.addSubview(bubbleLabel)
        
        bubbleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        viewModel.tabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.weekTabButton.setTitleColor(type == .week ? .primaryBlack : .minningGray100, for: .normal)
            self.monthTabButton.setTitleColor(type == .month ? .primaryBlack : .minningGray100, for: .normal)
            
            self.myRoutineView.isHidden = !(type == .week)
            self.monthGraphView.isHidden = !(type == .month)
            self.weeklyPercentView.isHidden = !(type == .week)
            self.routineCategoryView.isHidden = !(type == .month)
            
            self.updateBubbleLabel()
        }
    }
    
    @objc
    private func onClickComboButton(_ sender: UIButton) {
        DebugLog("Did Click Combo Button")
    }
    
    @objc
    private func onClickPercentGuideButton(_ sender: Any) {
        bubbleTriagleView.isHidden.toggle()
        bubbleView.isHidden.toggle()
        updateBubbleLabel()
    }
    
    @objc
    private func onClickBackground(_ sender: Any) {
        guard bubbleTriagleView.isHidden == false, bubbleView.isHidden == false else { return }
        bubbleTriagleView.isHidden = true
        bubbleView.isHidden = true
    }
    
    private func updateBubbleLabel() {
        bubbleLabel.text = viewModel.tabType.value == .week ? "매주 수요일마다 주 리포트가 갱신됩니다" : "매월 첫째주에 월 리포트가 갱신됩니다"
    }
}

extension ReportViewController: UIScrollViewDelegate {
    
}
