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
    
    init(viewModel: AddViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let rightBarButton: UIBarButtonItem = {
        $0.title = "완료"
        $0.tintColor = .systemBlue
        return $0
    }(UIBarButtonItem())
    
    private let stackView: UIStackView = {
        $0.axis = .vertical
//        $0.spacing = 16
//        $0.distribution = .equalSpacing
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
        $0.setTitle("👀 추천 루틴", for: .normal)
        $0.setTitleColor(.minningBlue100, for: .normal)
        $0.titleLabel?.font = .font16PBold
        $0.addTarget(self, action: #selector(isRecommendButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let writeRoutineNameLabel: UILabel = {
        $0.text = "루틴 이름 작성"
        $0.textColor = .minningDarkGray100
        $0.font = .font12P
        return $0
    }(UILabel())
    
    private let writeRoutineNameTextField: PlainTextField = {
        $0.placeholder = "ex. 아침에 물 한잔"
        $0.textColor = .black
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
        $0.textColor = .minningDarkGray100
        $0.font = .font12P
        return $0
    }(UILabel())
    
    private let writeGoalNameTextField: PlainTextField = {
        $0.placeholder = "ex. 작은것부터 차근차근!"
        $0.textColor = .black
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
        $0.text = "카테고리"
        $0.textColor = .minningDarkGray100
        $0.font = .font12P
        return $0
    }(UILabel())
    
    private let categoryIconStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
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
        $0.font = .font12P
        $0.textColor = .minningDarkGray100
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
    
    private let routineAlarmStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())
    
    private let routineAlarmTimeStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 1
        return $0
    }(UIStackView())
    
    private let routineAlarmLabel: UILabel = {
        $0.text = "루틴 시간 및 알림"
        $0.textColor = .minningDarkGray100
        $0.font = .font12P
        return $0
    }(UILabel())
    
    private let routineTimeView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIStackView())
    
    private let routineTimeLabel: UILabel = {
        $0.text = "시간"
        $0.font = .font16P
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let routineAlarmView: UIView = {
        $0.backgroundColor = .white
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let routineAlarmOnOffLabel: UILabel = {
        $0.text = "알림 보내기"
        $0.font = .font16P
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let timePickerView: UIView = {
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .gray767680
        $0.layer.cornerRadius = 6
        return $0
    }(UIView())
    
    private let timeLabel: UILabel = {
        $0.isUserInteractionEnabled = true
        $0.text = "12 : 34"
        $0.font = .font22P
        return $0
    }(UILabel())
    
    private let timePicker: UIDatePicker = {
        $0.datePickerMode = .time
        if #available(iOS 13.4, *) {
            $0.preferredDatePickerStyle = .wheels
        }
        return $0
    }(UIDatePicker())
    
    private let alarmSwitch: UISwitch = {
        $0.isOn = false
        return $0
    }(UISwitch())
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        view.addSubview(stackView)
        view.backgroundColor = .minningLightGray100
        
        stackView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.width.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-31)
            make.center.equalToSuperview()
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
            make.trailing.equalToSuperview()
            make.trailing.equalTo(-16)
        }
        stackView.setCustomSpacing(20.0, after: recommendButtonView)
        
        // MARK: - 루틴 이름 작성
        [writeRoutineNameLabel, writeRoutineNameTextField].forEach {
            routineNameStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(routineNameStackView)
        stackView.addArrangedSubview(numberOfRoutineLabel)
        
        routineNameStackView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        stackView.setCustomSpacing(4.0, after: routineNameStackView)
        
        numberOfRoutineLabel.snp.makeConstraints { make in
            make.top.equalTo(routineNameStackView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        stackView.setCustomSpacing(20.0, after: numberOfRoutineLabel)
        
        // MARK: - 루틴 목표 작성
        [writeGoalNameLabel, writeGoalNameTextField].forEach {
            routineGoalStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(routineGoalStackView)
        
        stackView.setCustomSpacing(4.0, after: routineGoalStackView)
        
        stackView.addArrangedSubview(numberOfGoalLabel)
        
        routineGoalStackView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.trailing.equalTo(-16)
        }
        
        numberOfGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(routineGoalStackView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        stackView.setCustomSpacing(20.0, after: numberOfGoalLabel)

        // MARK: - 카테고리
        [morningView, selfImproveView, healthView, lifeView, etcView].forEach {
            categoryIconStackView.addArrangedSubview($0)
        }
        
        morningView.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
        
        selfImproveView.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
        
        healthView.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
        
        lifeView.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
        
        etcView.snp.makeConstraints { make in
            make.width.equalTo(65)
        }

        [categoryLabel, categoryIconStackView].forEach {
            categoryStackView.addArrangedSubview($0)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
        }
        
        categoryIconStackView.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.trailing.equalTo(-16)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.height.equalTo(87)
        }
                
        stackView.addArrangedSubview(categoryStackView)
        
        stackView.setCustomSpacing(40.0, after: categoryStackView)
        
        // MARK: - 루틴 요일
        [monView, tueView, wedView, thuView, friView, satView, sunView].forEach {
            routineDayStackView.addArrangedSubview($0)
        }
        
        monView.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(38)
        }
        
        tueView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        wedView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        thuView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        friView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        satView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        sunView.snp.makeConstraints { make in
            make.width.equalTo(38)
        }
        
        [routineDayLabel, routineDayStackView].forEach {
            routineStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(routineStackView)
        
        routineStackView.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.trailing.equalTo(-16)
        }
        
        stackView.setCustomSpacing(20.0, after: routineStackView)
        
        // MARK: - 루틴 시간 및 알림
        [routineAlarmLabel].forEach {
            routineAlarmStackView.addArrangedSubview($0)
        }
        
        routineAlarmLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(14)
        }
        
        stackView.addArrangedSubview(routineAlarmStackView)
        
        routineAlarmStackView.snp.makeConstraints { make in
            make.height.equalTo(14)
        }
        
        stackView.setCustomSpacing(8.0, after: routineAlarmStackView)
        
        stackView.addArrangedSubview(routineAlarmTimeStackView)
        // MARK: - 시간, 알림 보내기
        [routineTimeView, routineAlarmView].forEach {
            routineAlarmTimeStackView.addArrangedSubview($0)
        }
        
        routineAlarmTimeStackView.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.leading.equalToSuperview()
//            make.top.equalTo(routineAlarmStackView.snp.bottom).offset(8)
        }
        
        [routineTimeLabel, timePickerView].forEach {
            routineTimeView.addSubview($0)
        }
        
        stackView.setCustomSpacing(1.0, after: routineTimeView)
        
        timePickerView.addSubview(timeLabel)
        timeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(timePressed(_:))))
        
        [routineAlarmOnOffLabel].forEach {
            routineAlarmView.addSubview($0)
        }
        
        timePickerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(86)
            make.height.equalTo(36)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        routineAlarmView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        routineAlarmView.addSubview(alarmSwitch)
        
        alarmSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
        
        routineTimeView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview()
        }
        
        routineAlarmView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview()
        }
        
        routineTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        routineAlarmOnOffLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "루틴 추가하기"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    @objc
    private func completePressed() {
        
    }
    
    @objc
    private func isRecommendButtonPressed() {
        viewModel.coordinator.goToRecommend()
    }
    
    @objc
    private func timePressed(_ sender: Any) {
        let alert = UIAlertController(title: "시간 선택", message: "알림 받을 시간을 선택해주세요", preferredStyle: .actionSheet)
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "선택완료", style: .default, handler: { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH : mm"
            self.timeLabel.text = formatter.string(from: self.timePicker.date)
        }))
        
        alert.view.tintColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00)
        
        alert.view.snp.makeConstraints { make in
            make.height.equalTo(350)
        }
        timePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(180)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func datePickerPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        let time = dateFormatter.string(from: timePicker.date)
        print(time)
    }
}
