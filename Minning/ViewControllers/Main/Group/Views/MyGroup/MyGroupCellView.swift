//
//  MyGroupCellView.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

class MyGroupCellView: UIView {
    var cellBackgroundView: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    var cellView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    var iconBackgroundView: UIImageView = {
        $0.layer.cornerRadius = 7
        return $0
    }(UIImageView())
    
    var iconImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    var titleLabel: UILabel = {
        $0.text = "새벽 독서 그룹"
        $0.font = .font18PBold
        return $0
    }(UILabel())
    
    var achieveRateView: UIView = {
        $0.backgroundColor = .minningBlue20
        $0.layer.cornerRadius = 5
        return $0
    }(UIView())
    
    var achieveRateLabel: UILabel = {
        $0.text = "내 달성률 100%"
        $0.textColor = .minningBlue100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    var achieveLabelCount: Int = 101
    
    var participantLabel: UILabel = {
        $0.text = "27명 참여중"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    var dayLabel: UILabel = {
        $0.text = "월, 수, 목"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    var dayLeftLabel: UILabel = {
        $0.text = "D-7"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(cellView)
        [iconBackgroundView, iconImageView, titleLabel, achieveRateView, achieveRateLabel, dayLabel, dayLeftLabel].forEach {
            cellView.addSubview($0)
        }
        
        layer.cornerRadius = 10
        backgroundColor = .white
        
        cellBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview()
        }
        
        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.leading).offset(10)
            make.trailing.equalTo(iconBackgroundView.snp.trailing).offset(-10)
            make.top.equalTo(iconBackgroundView.snp.top).offset(10)
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(16)
            make.top.equalTo(iconBackgroundView.snp.top)
        }
        
        achieveRateView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(achieveLabelCount)
            make.height.equalTo(23)
        }
        
        achieveRateLabel.snp.makeConstraints { make in
            make.center.equalTo(achieveRateView.snp.center)
            make.height.equalTo(14)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(achieveRateLabel.snp.top)
            make.leading.equalTo(achieveRateView.snp.trailing).offset(8)
        }
        
        dayLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(achieveRateLabel.snp.top)
            make.leading.equalTo(dayLabel.snp.trailing).offset(4)
        }
    }
}
