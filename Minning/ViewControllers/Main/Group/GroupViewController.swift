//
//  GroupViewController.swift
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

final class GroupViewController: BaseViewController {
    private let titleSectionContainerView: UIView = {
        $0.backgroundColor = .primaryWhite
        return $0
    }(UIView())
    
    private let myGroupTabButton: UIButton = {
        $0.setTitle("내 그룹", for: .normal)
        $0.titleLabel?.font = .font22PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let groupListTabButton: UIButton = {
        $0.setTitle("둘러보기", for: .normal)
        $0.titleLabel?.font = .font22PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let subTitleStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let subTabContainerView: UIView = UIView()
    
    private let subTabNowButton: UIButton = {
        $0.setTitle("진행중 3", for: .normal)
        $0.titleLabel?.font = .font16PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let subTabDoneButton: UIButton = {
        $0.setTitle("종료 5", for: .normal)
        $0.titleLabel?.font = .font16PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let filterScrollView: UIScrollView = {
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView())
    
    private let filterContainerView: UIView = UIView()
    private let filterStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIStackView())
    
    lazy var groupListTableView: UITableView = {
        $0.backgroundColor = .systemOrange
        return $0
    }(UITableView())
    
    private let viewModel: GroupViewModel
    
    public init(viewModel: GroupViewModel) {
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
    
    override func bindViewModel() {
        viewModel.tabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.myGroupTabButton.setTitleColor(type == .myGroup ? .primaryBlack : .minningGray100, for: .normal)
            self.groupListTabButton.setTitleColor(type == .groupList ? .primaryBlack : .minningGray100, for: .normal)
            
            self.subTabContainerView.isHidden = !(type == .myGroup)
            self.filterScrollView.isHidden = !(type == .groupList)
        }
        
        viewModel.myGroupTabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.subTabNowButton.setTitleColor(type == .now ? .primaryBlack : .minningGray100, for: .normal)
            self.subTabDoneButton.setTitleColor(type == .done ? .primaryBlack : .minningGray100, for: .normal)
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .minningLightGray100
        [titleSectionContainerView, groupListTableView].forEach {
            view.addSubview($0)
        }
        
        [myGroupTabButton, groupListTabButton, subTitleStackView].forEach {
            titleSectionContainerView.addSubview($0)
        }
        
        [subTabNowButton, subTabDoneButton].forEach {
            subTabContainerView.addSubview($0)
        }
        
        subTitleStackView.addArrangedSubview(subTabContainerView)
        subTitleStackView.addArrangedSubview(filterScrollView)
        filterScrollView.addSubview(filterContainerView)
        filterContainerView.addSubview(filterStackView)
        
        titleSectionContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        myGroupTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalToSuperview().offset(28)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        groupListTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalTo(myGroupTabButton.snp.trailing).offset(26)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        subTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(myGroupTabButton.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // MARK: Sub Tab Section
        subTabContainerView.snp.makeConstraints { make in
            make.height.equalTo(33)
        }
        
        subTabNowButton.snp.makeConstraints { make in
            make.top.bottom.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
        }
        
        subTabDoneButton.snp.makeConstraints { make in
            make.top.bottom.centerY.equalToSuperview()
            make.leading.equalTo(subTabNowButton.snp.trailing).offset(20)
        }
        
        // MARK: Category Section
        filterScrollView.snp.makeConstraints { make in
            make.height.equalTo(33)
            make.leading.trailing.equalToSuperview()
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupFilterview()
        
        groupListTableView.snp.makeConstraints { make in
            make.top.equalTo(titleSectionContainerView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.viewModel.showDetail()
        })
    }
    
    @objc
    private func onClickTabButton(_ sender: UIButton) {
        switch sender {
        case myGroupTabButton:
            viewModel.tabType.accept(.myGroup)
        case groupListTabButton:
            viewModel.tabType.accept(.groupList)
        case subTabNowButton:
            viewModel.myGroupTabType.accept(.now)
        case subTabDoneButton:
            viewModel.myGroupTabType.accept(.done)
        default:
            break
        }
    }
    
    private func setupFilterview() {
        let leadingSpacer = UIView()
        let trailingSpacer = UIView()
        [leadingSpacer, trailingSpacer].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(16)
            }
        }
        
        filterStackView.addArrangedSubview(leadingSpacer)
        filterStackView.setCustomSpacing(0, after: leadingSpacer)
        
        let filterButton = FilterButton()
        filterButton.isSelected = viewModel.isCurrentCategoryAll.value
        filterButton.isAll = true
        filterButton.setTitle("전체", for: .normal)
        filterButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
        filterStackView.addArrangedSubview(filterButton)
        filterStackView.addArrangedSubview(trailingSpacer)
        
        RoutineCategory.allCases.enumerated().forEach { index, category in
            let filterButton = FilterButton()
            filterButton.isSelected = viewModel.currentCategory.value == category
            filterButton.category = category
            filterButton.setTitle(category.title, for: .normal)
            filterButton.addTarget(self, action: #selector(onClickFilterButton(_:)), for: .touchUpInside)
            filterStackView.addArrangedSubview(filterButton)
            
            if index == RoutineCategory.allCases.count - 1 {
                filterStackView.addArrangedSubview(trailingSpacer)
                filterStackView.setCustomSpacing(0, after: filterButton)
            }
        }
    }
    
    private func updateFilterView() {
        filterStackView.arrangedSubviews.forEach { subView in
            if let filterButton = subView as? FilterButton {
                if filterButton.isAll {
                    filterButton.isSelected = viewModel.isCurrentCategoryAll.value
                } else {
                    filterButton.isSelected = filterButton.category == viewModel.currentCategory.value
                }
            }
        }
    }
    
    @objc
    private func onClickFilterButton(_ sender: FilterButton) {
        if sender.isAll {
            viewModel.isCurrentCategoryAll.accept(true)
            viewModel.currentCategory.accept(nil)
        } else {
            viewModel.isCurrentCategoryAll.accept(false)
            viewModel.currentCategory.accept(sender.category)
        }
        
        updateFilterView()
    }
}
