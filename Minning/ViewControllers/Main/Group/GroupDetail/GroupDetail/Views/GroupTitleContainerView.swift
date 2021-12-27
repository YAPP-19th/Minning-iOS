//
//  GroupTitleContainerView.swift
//  Minning
//
//  Created by 고세림 on 2021/11/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupTitleContainerView: UIView {
    
    private let titleContainerView: UIView = {
        $0.backgroundColor = .primaryWhite
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        return $0
    }(UIView())
    
    private let contentStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let topContentView = UIView()
    private let bottomContentView = UIView()
    
    private let titleImageViewContainer: UIView = {
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        $0.backgroundColor = .cateSky100
        return $0
    }(UIView())
    
    private let titleImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "categoryMiracleMorningIcon")?.withAlignmentRectInsets(UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10))
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.font = .font22PExBold
        $0.textColor = .primaryBlack
        $0.text = "명상 그룹"
        return $0
    }(UILabel())
    
    private let percentLabelContainer: UIView = {
        $0.backgroundColor = .minningBlue20
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private let percentLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .minningBlue100
        $0.text = "평균 달성률 20%"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let participateLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .minningDarkGray100
        $0.text = "27명 참여중"
        return $0
    }(UILabel())
    
    private let groupPercentTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "평균 달성률"
        return $0
    }(UILabel())
    
    private let groupPercentValueLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "90%"
        return $0
    }(UILabel())
    
    private let myPercentTitleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        $0.text = "내 달성률"
        return $0
    }(UILabel())
    
    private let myPercentValueLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .minningBlue100
        $0.text = "95%"
        return $0
    }(UILabel())
    
    private let medalImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "medal_gold")
        return $0
    }(UIImageView())
    
    private let viewType: GroupViewType

    init(viewType: GroupViewType) {
        self.viewType = viewType
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOpenedView(title: String, rate: Int?, participant: Int?) {
        titleLabel.text = title + " 그룹"
        if let rate = rate {
            percentLabel.text = "평균 달성률 \(rate)%"
        } else {
            percentLabelContainer.isHidden = true
        }
        if let participant = participant {
            participateLabel.text = "\(participant)명 참여중"
        } else {
            participateLabel.isHidden = true
        }
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        addSubview(titleContainerView)
        titleContainerView.addSubview(contentStackView)
        titleImageViewContainer.addSubview(titleImageView)
        percentLabelContainer.addSubview(percentLabel)

        [topContentView, bottomContentView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [titleImageViewContainer, titleLabel, percentLabelContainer, participateLabel].forEach {
            topContentView.addSubview($0)
        }
        
        [groupPercentTitleLabel, groupPercentValueLabel, myPercentTitleLabel, myPercentValueLabel, medalImageView].forEach {
            bottomContentView.addSubview($0)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
        
        titleImageViewContainer.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.leading.equalTo(20)
            make.width.height.equalTo(50)
        }
        
        titleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(22)
            make.leading.equalTo(titleImageViewContainer.snp.trailing).offset(16)
            make.trailing.equalTo(-20)
        }
        
        percentLabelContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(25)
            make.bottom.equalTo(-19)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(7)
            make.trailing.equalTo(-7)
        }
                
        participateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(percentLabelContainer)
            make.leading.equalTo(percentLabelContainer.snp.trailing).offset(8)
        }
        
        groupPercentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(33)
            make.leading.equalTo(20)
        }
        
        groupPercentValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(groupPercentTitleLabel)
            make.trailing.equalTo(-23)
        }
        
        myPercentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(groupPercentTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(20)
            make.bottom.equalTo(-19)
        }
        
        myPercentValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(myPercentTitleLabel)
            make.trailing.equalTo(-23)
        }
        
        medalImageView.snp.makeConstraints { make in
            make.width.equalTo(11)
            make.height.equalTo(17)
            make.centerY.equalTo(myPercentValueLabel)
            make.trailing.equalTo(myPercentValueLabel.snp.leading).offset(-8)
        }
        
        switch viewType {
        case .openedGroup:
            bottomContentView.isHidden = true
        case .myGroup:
            percentLabelContainer.isHidden = true
        case .closedGroup:
            medalImageView.isHidden = true
        }
    }
    
}
