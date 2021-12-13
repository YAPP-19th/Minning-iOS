//
//  RoutinePercentDetailView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/12.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class RoutinePercentDetailView: UIView {
    
    private let typeImageView = UIImageView()
    private let titleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    
    private let percentLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    init(type: RoutineResult, percent: CGFloat) {
        super.init(frame: .zero)
        typeImageView.image = type.symbolImage
        titleLabel.text = type.title
        percentLabel.text = "\(Int(percent))%"
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        [typeImageView, titleLabel, percentLabel].forEach {
            addSubview($0)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-30)
            make.centerY.equalToSuperview()
        }
    }
    
}
