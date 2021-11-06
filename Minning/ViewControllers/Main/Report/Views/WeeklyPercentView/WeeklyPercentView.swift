//
//  WeeklyPercentView.swift
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

final class WeeklyPercentView: UIView {
    private let titleLabel: UILabel = {
        $0.text = "이번주 내 달성률"
        $0.font = .font16P
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    private let percentGuideButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "questionButton.png"), for: .normal)
        return $0
    }(UIButton())
    
    private let titleStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .bottom
        return $0
    }(UIStackView())
    
    private let percentValueLabel: UILabel = {
        $0.text = "90"
        $0.font = .font50PHeavy
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let percentLabel: UILabel = {
        $0.text = "%"
        $0.font = .font30P
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let percentStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private let descriptionLabel: UILabel = {
        $0.text = "일주일동안 고생했어요 👍"
        $0.font = .font22PExBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let resultStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 0
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        
        [descriptionLabel, percentStackView, titleStackView, resultStackView].forEach {
            addSubview($0)
        }
        [percentValueLabel, percentLabel].forEach {
            percentStackView.addArrangedSubview($0)
        }
        [titleLabel, percentGuideButton].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        let completeView = WeeklyResultView(resultType: .complete, count: 10)
        let halfView = WeeklyResultView(resultType: .half, count: 10)
        let incompleteView = WeeklyResultView(resultType: .incomplete, count: 10)
        [completeView, halfView, incompleteView].forEach {
            resultStackView.addArrangedSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        percentStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.leading.equalTo(20)
        }
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(percentStackView.snp.bottom).offset(4)
            make.leading.equalTo(20)
        }
        resultStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleStackView.snp.bottom).offset(52)
            make.bottom.equalTo(-20)
            make.height.equalTo(120)
        }
    }
}
