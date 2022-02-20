//
//  JoinGroupViewController.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class JoinGroupViewController: BaseViewController {
    private let backgroundView: UIView = UIView()
    private let contentView: UIView = {
        $0.backgroundColor = .primaryWhite
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return $0
    }(UIView())
    
    private let titleSectionLabel: UILabel = {
        $0.text = "그룹 참여 기간"
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let periodItemViews: [UIView] = []
    private let dayItemViews: [UIView] = []
    private let notiItemViews: [UIView] = []
    
    private let daySectionLabel: UILabel = {
        $0.text = "그룹 참여 요일"
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let notiSectionLabel: UILabel = {
        $0.text = "알림"
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let periodStackView: UIStackView = {
        $0.distribution = .equalSpacing
        $0.spacing = 8
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let dayStackView: UIStackView = {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let notiStackView: UIStackView = {
        $0.distribution = .equalSpacing
        $0.spacing = 8
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let joinButton: PlainButton = {
        $0.setTitle("참여하기", for: .normal)
        $0.addTarget(self, action: #selector(onClickJoin(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    public var completion: ((Bool) -> Void)?
    
    private let viewModel: JoinGroupViewModel
    
    public init(viewModel: JoinGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showUpJoinGroupView(completion: nil)
        
        updatePeriodButtons()
        updateDayButtons()
        updateNotiButtons()
    }
    
    override func bindViewModel() {
        viewModel.selectedPeriod.bind { [weak self] periodIndex in
            guard let `self` = self else { return }
            self.updatePeriodButtons()
        }
        
        viewModel.selectedDay.bind { [weak self] periodIndex in
            guard let `self` = self else { return }
            self.updateDayButtons()
        }
        
        viewModel.selectedNoti.bind { [weak self] periodIndex in
            guard let `self` = self else { return }
            self.updateNotiButtons()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .clear
        backgroundView.backgroundColor = .primaryBlack040
        backgroundView.alpha = 0
        
        [backgroundView, contentView].forEach {
            view.addSubview($0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        [joinButton, titleSectionLabel,
         daySectionLabel, notiSectionLabel,
         periodStackView, dayStackView,
         notiStackView].forEach {
            contentView.addSubview($0)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let keyWindow = UIApplication.shared.windows.first {
            contentView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(400 + keyWindow.safeAreaInsets.bottom)
                make.height.equalTo(400 + keyWindow.safeAreaInsets.bottom)
            }
        }
        
        titleSectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33)
            make.leading.equalToSuperview().offset(26)
        }
        
        periodStackView.snp.makeConstraints { make in
            make.top.equalTo(titleSectionLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(33)
        }
        
        daySectionLabel.snp.makeConstraints { make in
            make.top.equalTo(periodStackView.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(26)
        }
        
        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(daySectionLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-11)
            make.height.equalTo(38)
        }
        
        notiSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(dayStackView.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(26)
        }
        
        notiStackView.snp.makeConstraints { make in
            make.top.equalTo(notiSectionLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(33)
        }
        
        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(334)
        }
        
        setupItemButtons()
    }
    
    private func setupItemButtons() {
        for symbol in viewModel.periodSymbols {
            let button = PlainSmallButton()
            button.cornerRadius = 7
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            button.title = symbol
            button.isButtonSelected = false
            button.addTarget(self, action: #selector(updatePeriodButtons), for: .touchUpInside)
            
            periodStackView.addArrangedSubview(button)
        }
        
        for symbol in viewModel.daySymbols {
            let button = PlainSmallButton()
            button.cornerRadius = 19
            button.title = symbol
            button.isButtonSelected = false
            button.addTarget(self, action: #selector(updateDayButtons), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.width.height.equalTo(38)
            }
            dayStackView.addArrangedSubview(button)
        }
        
        for symbol in viewModel.notiSymbols {
            let button = PlainSmallButton()
            button.cornerRadius = 7
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            button.title = symbol
            button.isButtonSelected = false
            button.addTarget(self, action: #selector(updateNotiButtons), for: .touchUpInside)
            notiStackView.addArrangedSubview(button)
        }
    }
    
    @objc
    private func updatePeriodButtons() {
        if let index = viewModel.selectedPeriod.value {
            periodStackView.subviews.enumerated().forEach { pIndex, view in
                if let periodView = view as? PlainSmallButton {
                    periodView.isButtonSelected = index == pIndex
//                    periodView.backgroundColor = (index == pIndex) ? .minningDarkGray100 : .minningLightGray100
                }
            }
        } else {
            periodStackView.subviews.forEach { view in
                if let periodView = view as? PlainSmallButton {
                    periodView.isButtonSelected = false
                }
            }
        }
    }
    
    @objc
    private func updateDayButtons() {
        if let index = viewModel.selectedDay.value {
            dayStackView.subviews.enumerated().forEach { dIndex, view in
                if let dayView = view as? PlainSmallButton {
                    dayView.isButtonSelected = index == dIndex
//                    dayView.backgroundColor = (index == dIndex) ? .minningDarkGray100 : .minningLightGray100
                }
            }
        } else {
            dayStackView.subviews.forEach { view in
                if let dayView = view as? PlainSmallButton {
                    dayView.isButtonSelected = false
                }
            }
        }
    }
    
    @objc
    private func updateNotiButtons() {
        if let index = viewModel.selectedNoti.value {
            notiStackView.subviews.enumerated().forEach { nIndex, view in
                if let notiView = view as? PlainSmallButton {
                    notiView.isButtonSelected = index == nIndex
//                    notiView.backgroundColor = (index == nIndex) ? .minningDarkGray100 : .minningLightGray100
                }
            }
        } else {
            notiStackView.subviews.forEach { view in
                if let notiView = view as? PlainSmallButton {
                    notiView.isButtonSelected = false
                }
            }
        }
    }
    
    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        hideDownJoinGroupView(completion: { _ in
            self.completion?(false)
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @objc
    private func onClickJoin(_ sender: UIButton) {
        hideDownJoinGroupView(completion: { _ in
            self.completion?(true) // TEMP
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func showUpJoinGroupView(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.backgroundView.alpha = 1
            if let keyWindow = UIApplication.shared.windows.first {
                self.contentView.frame.origin.y = keyWindow.frame.height - 400 - keyWindow.safeAreaInsets.bottom
            }
        }, completion: completion)
    }
    
    private func hideDownJoinGroupView(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.backgroundView.alpha = 0
            if let keyWindow = UIApplication.shared.windows.first {
                self.contentView.frame.origin.y = keyWindow.frame.height
            }
        }, completion: { result in
            completion?(result)
        })
    }
}
