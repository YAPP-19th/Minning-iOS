//
//  RoutineCompareDetailView.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class RoutineCompareDetailView: UIView {
    
    private let titleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let percentStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let separatorView: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    let routine: MonthlyRoutine
    
    init(routine: MonthlyRoutine) {
        self.routine = routine
        super.init(frame: .zero)
        titleLabel.text = routine.title
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleLabel, percentStackView, separatorView].forEach {
            addSubview($0)
        }
        
        let donePercentView = RoutinePercentDetailView(type: .done, percent: routine.donePercent)
        let triedPercentView = RoutinePercentDetailView(type: .tried, percent: routine.triedPercent)
        let failurePercentView = RoutinePercentDetailView(type: .failure, percent: routine.failurePercent)
        [donePercentView, triedPercentView, failurePercentView].forEach {
            percentStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
        }
        
        percentStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(percentStackView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
}
