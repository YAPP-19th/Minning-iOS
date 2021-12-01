//
//  ReportEmptyView.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ReportEmptyView: UIView {
    private let characterView: UIImageView = {
        $0.image = UIImage(sharedNamed: "reportEmptyIcon")
        return $0
    }(UIImageView())
    
    private let contentLabel: UILabel = {
        $0.text = "아직 리포트가 나오지 않았어요"
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let subcontentLabel: UILabel = {
        $0.text = "주 리포트는 매주 수요일,\n월 리포트는 매월 첫째주에 확인할 수 있어요"
        $0.font = .font16P
        $0.textColor = .gray787C84
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
        backgroundColor = .minningLightGray100
        [characterView, contentLabel, subcontentLabel].forEach {
            addSubview($0)
        }
        
        characterView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(138)
            make.center.equalToSuperview()
            make.width.equalTo(209)
            make.height.equalTo(105)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(characterView.snp.bottom).offset(41)
            make.center.equalToSuperview()
        }
        
        subcontentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(31)
            make.center.equalToSuperview()
        }
    }
}
