//
//  GroupRuleContainerView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupRuleContainerView: UIView {
    
    private let titleLabel: UILabel = {
        $0.font = .font20PExBold
        $0.textColor = .primaryBlack
        $0.text = "그룹 규칙"
        return $0
    }(UILabel())
    
    private let pictureImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "rule_camera")
        return $0
    }(UIImageView())
    
    private let pictureTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "찍어주세요"
        return $0
    }(UILabel())
    
    private let pictureValueLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        $0.text = "물컵 사진"
        return $0
    }(UILabel())
    
    private let ruleImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "rule_exclamation")
        return $0
    }(UIImageView())
    
    private let ruleTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "지켜주세요"
        return $0
    }(UILabel())
    
    private let ruleValueLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        $0.text = "오전 5시~8시 사이 업로드"
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
        [titleLabel, pictureImageView, pictureTitleLabel, pictureValueLabel, ruleImageView, ruleTitleLabel, ruleValueLabel, separatorView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
        }
        
        pictureImageView.snp.makeConstraints { make in
            make.width.equalTo(18)
            make.height.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(20)
        }
        
        pictureTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
        }
        
        pictureValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(pictureTitleLabel)
        }
        
        ruleImageView.snp.makeConstraints { make in
            make.width.equalTo(6)
            make.height.equalTo(15)
            make.centerX.equalTo(pictureImageView)
            make.top.equalTo(pictureImageView.snp.bottom).offset(26)
        }
        
        ruleTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureTitleLabel)
            make.top.equalTo(pictureTitleLabel.snp.bottom).offset(21)
        }
        
        ruleValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(ruleTitleLabel)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(ruleTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }
    
}
