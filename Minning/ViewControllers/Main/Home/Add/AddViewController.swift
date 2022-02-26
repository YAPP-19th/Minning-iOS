//
//  AddViewController.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit
import UIKit

final class AddViewController: BaseViewController {
    private let routineAlarmTableView = UITableView()
    private let viewModel: AddViewModel
    
    private lazy var rightBarButton: UIBarButtonItem = {
        $0.title = "완료"
        $0.tintColor = .systemBlue
        $0.addTargetForAction(target: self, action: #selector(onClickCompleteButton(_:)))
        return $0
    }(UIBarButtonItem())
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let scrollContainerView: UIView = UIView()
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let routineNameStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let recommendButtonView: UIView = {
        return $0
    }(UIView())
    
    private let recommendButton: UIButton = {
        $0.setTitle("  추천 루틴  ", for: .normal)
        $0.setTitleColor(.minningBlue100, for: .normal)
        $0.titleLabel?.font = .font16P
        $0.addTarget(self, action: #selector(isRecommendButtonPressed), for: .touchUpInside)
        $0.backgroundColor = .primaryWhite
        $0.layer.borderColor = UIColor.minningBlue100.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        return $0
    }(UIButton())
    
    private let writeRoutineNameLabel: UILabel = {
        $0.text = "루틴 이름 작성"
        $0.textColor = .primaryBlack
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let writeRoutineNameTextField: PlainTextField = {
        $0.placeholder = "ex. 아침에 물 한잔"
        $0.textColor = .gray787C84
        $0.backgroundColor = .minningLightGray100
        return $0
    }(PlainTextField())
    
    private let numberOfRoutineLabel: UILabel = {
        $0.text = "0/15"
        $0.font = .font14P
        $0.textColor = .minningDarkGray100
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private let routineGoalStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let writeGoalNameLabel: UILabel = {
        $0.text = "루틴 목표 작성"
        $0.textColor = .primaryBlack
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let writeGoalNameTextField: PlainTextField = {
        $0.placeholder = "ex. 작은것부터 차근차근!"
        $0.textColor = .gray787C84
        $0.backgroundColor = .minningLightGray100
        return $0
    }(PlainTextField())
    
    private let numberOfGoalLabel: UILabel = {
        $0.text = "0/20"
        $0.font = .font14P
        $0.textColor = .minningDarkGray100
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private let categoryStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let categoryLabel: UILabel = {
        $0.text = "카테고리 설정"
        $0.textColor = .primaryBlack
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let categoryScrollView = UIScrollView()
    
    private let categoryIconStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let leadingEmptyView: UIView = {
        return $0
    }(UIView())
    
    private let trailingEmptyView: UIView = {
        return $0
    }(UIView())
    
    private let morningView: AddCategoryView = {
        return $0
    }(AddCategoryView(category: .miracleMorning))
    
    private let selfImproveView: AddCategoryView = {
        return $0
    }(AddCategoryView(category: .selfImprove))
    
    private let healthView: AddCategoryView = {
        return $0
    }(AddCategoryView(category: .health))
    
    private let lifeView: AddCategoryView = {
        return $0
    }(AddCategoryView(category: .life))
    
    private let etcView: AddCategoryView = {
        return $0
    }(AddCategoryView(category: .etc))
    
    lazy var morningEmptyView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(miracleButtonSelected)))
        return $0
    }(UIView())
    
    lazy var morningSelectedView: UIView = {
        $0.backgroundColor = UIColor.primaryBlack040
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    lazy var morningSelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    lazy var selfImproveEmptyView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfImproveButtonSelected)))
        return $0
    }(UIView())
    
    lazy var selfImproveSelectedView: UIView = {
        $0.backgroundColor = UIColor.primaryBlack040
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    lazy var selfImproveSelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    lazy var healthEmptyView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(healthButtonSelected)))
        return $0
    }(UIView())
    
    lazy var healthSelectedView: UIView = {
        $0.backgroundColor = UIColor.primaryBlack040
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    lazy var healthSelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    lazy var lifeEmptyView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lifeButtonSelected)))
        return $0
    }(UIView())
    
    lazy var lifeSelectedView: UIView = {
        $0.backgroundColor = UIColor.primaryBlack040
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    lazy var lifeSelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    lazy var etcEmptyView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(etcButtonSelected)))
        return $0
    }(UIView())
    
    lazy var etcSelectedView: UIView = {
        $0.backgroundColor = UIColor.primaryBlack040
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    lazy var etcSelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    private let gapLine: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    private let routineDayStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private let routineStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let routineDayLabel: UILabel = {
        $0.text = "루틴 요일"
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let monView: AddDayView = {
        return $0
    }(AddDayView(day: .mon))
    
    private let tueView: AddDayView = {
        return $0
    }(AddDayView(day: .tue))
    
    private let wedView: AddDayView = {
        return $0
    }(AddDayView(day: .wed))
    
    private let thuView: AddDayView = {
        return $0
    }(AddDayView(day: .thu))
    
    private let friView: AddDayView = {
        return $0
    }(AddDayView(day: .fri))
    
    private let satView: AddDayView = {
        return $0
    }(AddDayView(day: .sat))
    
    private let sunView: AddDayView = {
        return $0
    }(AddDayView(day: .sun))
    
    private let deleteContainer: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    private let deleteLabel: UILabel = {
        let string = "루틴 삭제하기"
        let attString = NSMutableAttributedString(string: string)
        attString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: .init(location: 0, length: attString.length))
        $0.attributedText = attString
        $0.isUserInteractionEnabled = true
        $0.textColor = .primaryBlack
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        return $0
    }(UILabel())
    
    init(viewModel: AddViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupViewLayout() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.addSubview(stackView)
        
        scrollContainerView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(19)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-19)
            make.width.equalTo(scrollView.snp.width)
        }

        // MARK: - 추천 루틴
        stackView.addArrangedSubview(recommendButtonView)
        recommendButtonView.addSubview(recommendButton)
        
        recommendButtonView.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.trailing.equalTo(-16)
        }
        
        recommendButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(-16)
        }
        stackView.setCustomSpacing(20.0, after: recommendButtonView)
        
        // MARK: - 루틴 이름 작성
        [writeRoutineNameLabel, writeRoutineNameTextField].forEach {
            routineNameStackView.addArrangedSubview($0)
        }
        
        writeRoutineNameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stackView.addArrangedSubview(routineNameStackView)
        stackView.addArrangedSubview(numberOfRoutineLabel)
        
        routineNameStackView.snp.makeConstraints { make in
            make.height.equalTo(88)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        stackView.setCustomSpacing(4.0, after: routineNameStackView)
        
        numberOfRoutineLabel.snp.makeConstraints { make in
            make.top.equalTo(routineNameStackView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        stackView.setCustomSpacing(19.0, after: numberOfRoutineLabel)
        
        // MARK: - 루틴 목표 작성
        [writeGoalNameLabel, writeGoalNameTextField].forEach {
            routineGoalStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(routineGoalStackView)
        
        stackView.setCustomSpacing(40.0, after: routineGoalStackView)
        
        stackView.addArrangedSubview(numberOfGoalLabel)
        
        writeGoalNameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        routineGoalStackView.snp.makeConstraints { make in
            make.height.equalTo(88)
            make.trailing.equalTo(-16)
        }
        
        numberOfGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(routineGoalStackView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        stackView.setCustomSpacing(19.0, after: numberOfGoalLabel)

        // MARK: - 카테고리
        categoryScrollView.addSubview(categoryIconStackView)
        
        [leadingEmptyView, morningView, selfImproveView, healthView, lifeView, etcView, trailingEmptyView].forEach {
            categoryIconStackView.addArrangedSubview($0)
        }
        
        leadingEmptyView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(65)
        }
        
        morningView.addSubview(morningEmptyView)
        morningSelectedView.addSubview(morningSelectedImageView)
        morningEmptyView.addSubview(morningSelectedView)
        morningSelectedView.isHidden = true
        
        morningView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        morningEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(morningView)
        }
        morningSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(morningEmptyView)
        }
        
        morningSelectedImageView.snp.makeConstraints { make in
            make.center.equalTo(morningEmptyView)
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        selfImproveView.addSubview(selfImproveEmptyView)
        selfImproveSelectedView.addSubview(selfImproveSelectedImageView)
        selfImproveEmptyView.addSubview(selfImproveSelectedView)
        selfImproveSelectedView.isHidden = true

        selfImproveView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        selfImproveEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(selfImproveView)
        }
        selfImproveSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(selfImproveEmptyView)
        }
        
        selfImproveSelectedImageView.snp.makeConstraints { make in
            make.center.equalTo(selfImproveEmptyView)
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        healthView.addSubview(healthEmptyView)
        healthSelectedView.addSubview(healthSelectedImageView)
        healthEmptyView.addSubview(healthSelectedView)
        healthSelectedView.isHidden = true
        
        healthView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        healthEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(healthView)
        }
        healthSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(healthEmptyView)
        }
        
        healthSelectedImageView.snp.makeConstraints { make in
            make.center.equalTo(healthEmptyView)
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        lifeView.addSubview(lifeEmptyView)
        lifeSelectedView.addSubview(lifeSelectedImageView)
        lifeEmptyView.addSubview(lifeSelectedView)
        lifeSelectedView.isHidden = true
        
        lifeView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        lifeEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(lifeView)
        }
        lifeSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(lifeEmptyView)
        }
        
        lifeSelectedImageView.snp.makeConstraints { make in
            make.center.equalTo(lifeEmptyView)
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        etcView.addSubview(etcEmptyView)
        etcSelectedView.addSubview(etcSelectedImageView)
        etcEmptyView.addSubview(etcSelectedView)
        etcSelectedView.isHidden = true
        
        etcView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        etcEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(etcView)
        }
        etcSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(etcEmptyView)
        }
        
        etcSelectedImageView.snp.makeConstraints { make in
            make.center.equalTo(etcEmptyView)
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        trailingEmptyView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(65)
        }
        
        [categoryLabel, categoryScrollView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.setCustomSpacing(14.0, after: categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        categoryScrollView.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.leading.trailing.equalToSuperview()
        }
        
        categoryIconStackView.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.leading.trailing.equalToSuperview()
        }
        
        stackView.setCustomSpacing(20.0, after: categoryScrollView)
        
        // MARK: - Gap Line
        stackView.addArrangedSubview(gapLine)
        
        gapLine.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.leading.equalToSuperview()
        }
        
        stackView.setCustomSpacing(20.0, after: gapLine)
        
        // MARK: - 루틴 요일
        [monView, tueView, wedView, thuView, friView, satView, sunView].forEach {
            routineDayStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.width.equalTo(38)
            }
        }
        
        monView.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        [routineDayLabel, routineDayStackView].forEach {
            routineStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(routineStackView)
        
        routineDayStackView.snp.makeConstraints { make in
            make.top.equalTo(routineDayLabel.snp.bottom).offset(14)
            make.height.equalTo(38)
        }
        
        routineStackView.snp.makeConstraints { make in
            make.height.equalTo(76)
            make.trailing.equalTo(-16)
        }
        
        stackView.setCustomSpacing(40.0, after: routineStackView)
        
        if viewModel.routineId != nil {
            setModifyView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = viewModel.routineId != nil ? "루틴 추가하기" : "루틴 수정하기"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setModifyView() {
        writeRoutineNameTextField.text = viewModel.title
        writeGoalNameTextField.text = viewModel.goal
        if let category = viewModel.selectedCategoryIndex {
            switch category {
            case 0:
                morningSelectedView.isHidden = false
            case 1:
                selfImproveSelectedView.isHidden = false
            case 2:
                healthSelectedView.isHidden = false
            case 3:
                lifeSelectedView.isHidden = false
            case 4:
                etcSelectedView.isHidden = false
            default:
                break
            }
        }
        viewModel.selectedDays.forEach { day in
            switch day {
            case .mon:
                monView.isSelected = true
            case .tue:
                tueView.isSelected = true
            case .wed:
                wedView.isSelected = true
            case .thu:
                thuView.isSelected = true
            case .fri:
                friView.isSelected = true
            case .sat:
                satView.isSelected = true
            case .sun:
                sunView.isSelected = true
            }
        }
        stackView.addArrangedSubview(deleteContainer)
        deleteContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        deleteContainer.addSubview(deleteLabel)
        deleteLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-60)
        }
        deleteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickDeleteLabel)))
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    @objc
    private func onClickCompleteButton(_ sender: Any) {
        let selectedDays = getSelectedDays()
        guard let selectedCategory = RoutineCategory(rawValue: viewModel.selectedCategoryIndex ?? 0) else { return }
        guard let title = writeRoutineNameTextField.text,
              let goal = writeGoalNameTextField.text else { return }
        if selectedDays.isEmpty { return }

        if viewModel.routineId != nil {
            viewModel.patchModifyRoutine(title: title, goal: goal, category: selectedCategory, days: selectedDays) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            viewModel.postAddRoutine(title: title, goal: goal, category: selectedCategory, days: selectedDays) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc
    private func isRecommendButtonPressed() {
        viewModel.coordinator.goToRecommend()
    }
    
    @objc
    private func onClickDeleteLabel(_ sender: Any?) {
        viewModel.deleteRoutine()
    }
    
    @objc
    private func miracleButtonSelected(_ sender: Any) {
        morningSelectedView.isHidden = false
        selfImproveSelectedView.isHidden = true
        healthSelectedView.isHidden = true
        lifeSelectedView.isHidden = true
        etcSelectedView.isHidden = true
        viewModel.selectedCategoryIndex = 0
    }
    
    @objc
    private func selfImproveButtonSelected(_ sender: Any) {
        morningSelectedView.isHidden = true
        selfImproveSelectedView.isHidden = false
        healthSelectedView.isHidden = true
        lifeSelectedView.isHidden = true
        etcSelectedView.isHidden = true
        viewModel.selectedCategoryIndex = 1
    }
    
    @objc
    private func healthButtonSelected(_ sender: Any) {
        morningSelectedView.isHidden = true
        selfImproveSelectedView.isHidden = true
        healthSelectedView.isHidden = false
        lifeSelectedView.isHidden = true
        etcSelectedView.isHidden = true
        viewModel.selectedCategoryIndex = 2
    }
    
    @objc
    private func lifeButtonSelected(_ sender: Any) {
        morningSelectedView.isHidden = true
        selfImproveSelectedView.isHidden = true
        healthSelectedView.isHidden = true
        lifeSelectedView.isHidden = false
        etcSelectedView.isHidden = true
        viewModel.selectedCategoryIndex = 3
    }
    
    @objc
    private func etcButtonSelected(_ sender: Any) {
        morningSelectedView.isHidden = true
        selfImproveSelectedView.isHidden = true
        healthSelectedView.isHidden = true
        lifeSelectedView.isHidden = true
        etcSelectedView.isHidden = false
        viewModel.selectedCategoryIndex = 4
    }
    
    private func getSelectedDays() -> [Day] {
        var selectedDays = [Day]()
        [monView, tueView, wedView, thuView, friView, satView, sunView].forEach {
            if $0.isSelected { selectedDays.append($0.day) }
        }
        return selectedDays
    }
}
