//
//  PhotoSelectView.swift
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

final class PhotoSelectButton: UIButton {
    private let addImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "add")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .primaryWhite
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    private let addTitleLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryWhite
        $0.text = "사진 0/1"
        $0.isUserInteractionEnabled = false
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
        [addImageView, addTitleLabel].forEach {
            addSubview($0)
        }
        
        addImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        addTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(addImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .minningGray100
    }
}
