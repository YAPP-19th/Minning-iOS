//
//  GroupMyInfoContainerView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupMyInfoContainerView: UIView {

    private let titleLabel: UILabel = {
        $0.font = .font20PExBold
        $0.textColor = .primaryBlack
        $0.text = "나의 참여 정보"
        return $0
    }(UILabel())
    
    private let termImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "info_term")
        return $0
    }(UIImageView())
    
    private let termTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "참여 기간"
        return $0
    }(UILabel())
    
    private let termValueLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        $0.text = "7일 남음 (10월 15일까지)"
        return $0
    }(UILabel())
    
    private let dayImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "info_day")
        return $0
    }(UIImageView())
    
    private let dayTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "참여 요일"
        return $0
    }(UILabel())
    
    private let dayValueLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        $0.text = "월,수,금"
        return $0
    }(UILabel())
    
    private let alarmImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "info_alarm")
        return $0
    }(UIImageView())
    
    private let alarmTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "알림"
        return $0
    }(UILabel())
    
    private let alarmValueLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        $0.text = "오전 7시"
        return $0
    }(UILabel())
    
    private let separatorView: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        [titleLabel, termImageView, termTitleLabel, termValueLabel, dayImageView, dayTitleLabel, dayValueLabel, alarmImageView, alarmTitleLabel, alarmValueLabel, separatorView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
        }
        
        termImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(29)
            make.leading.equalTo(20)
        }
        
        termTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(termImageView.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
        }
        
        termValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(termTitleLabel)
        }
        
        dayImageView.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.centerX.equalTo(termImageView)
            make.top.equalTo(termImageView.snp.bottom).offset(29)
        }
        
        dayTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(termTitleLabel)
            make.top.equalTo(termTitleLabel.snp.bottom).offset(21)
        }
        
        dayValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(dayTitleLabel)
        }
        
        alarmImageView.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(16)
            make.centerX.equalTo(dayImageView)
            make.top.equalTo(dayImageView.snp.bottom).offset(25)
        }
        
        alarmTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayTitleLabel)
            make.top.equalTo(dayTitleLabel.snp.bottom).offset(21)
        }
        
        alarmValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(alarmTitleLabel)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(alarmTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }

}
