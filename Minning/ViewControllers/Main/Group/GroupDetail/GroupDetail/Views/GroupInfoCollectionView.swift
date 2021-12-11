//
//  GroupInfoCollectionView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupInfoCollectionView: UIView {

    private let groupInfoTitleLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "그룹 설명"
        return $0
    }(UILabel())
    
    private let groupInfoLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .minningDarkGray100
        $0.text = "아침에 마시는 물 한잔만큼 상쾌한 것이 없죠!"
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let descriptionTitleLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "이렇게 해보세요"
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .minningDarkGray100
        $0.text = "명상을 처음 접해본다면, 호흡부터 시작해보세요.\n기도를 통해 들어가 발끝까지 뻗어나가는 호흡을 조용히 느껴 보며 머리의 생각을 비워보세요.. 어쩌구"
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [groupInfoTitleLabel, groupInfoLabel, descriptionTitleLabel, descriptionLabel].forEach {
            addSubview($0)
        }
        
        groupInfoTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
        }
        
        groupInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(groupInfoTitleLabel.snp.bottom).offset(14)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(groupInfoLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(14)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-40)
        }
    }
    
}
