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
    
    // MARK: Report Content View
    private let weeklyPercentView: WeeklyPercentView = WeeklyPercentView()
    private let myRoutineView: MyRoutineView = MyRoutineView()
    private let monthGraphView: MonthGraphView = MonthGraphView()
    private let routineCompareView: RoutineCompareView = RoutineCompareView()
    
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
        view.backgroundColor = .grayE5E5E5
        
        [weekTabButton, monthTabButton,
         dataComboButton, scrollView].forEach {
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
         monthGraphView, routineCompareView].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    override func bindViewModel() {
        viewModel.tabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.weekTabButton.setTitleColor(type == .week ? .primaryBlack : .primaryGray, for: .normal)
            self.monthTabButton.setTitleColor(type == .month ? .primaryBlack : .primaryGray, for: .normal)
            
            self.weeklyPercentView.isHidden = !(type == .week)
            self.myRoutineView.isHidden = !(type == .week)
            self.monthGraphView.isHidden = !(type == .month)
            self.routineCompareView.isHidden = !(type == .month)
        }
    }
    
    @objc
    private func onClickComboButton(_ sender: UIButton) {
        DebugLog("Did Click Combo Button")
    }
}

extension ReportViewController: UIScrollViewDelegate {
    
}
