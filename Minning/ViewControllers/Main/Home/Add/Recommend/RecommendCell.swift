//
//  RecommendCell.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/18.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    static let identifier = "RecommendCell"

    let titleLabel: UILabel = {
        $0.font = .font16PBold
        return $0
    }(UILabel())
    
    let contentLabel: UILabel = {
        $0.font = .font14P
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
    
    func setupView() {
        backgroundColor = .minningLightGray100
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(10)
        }
        
    }
}
