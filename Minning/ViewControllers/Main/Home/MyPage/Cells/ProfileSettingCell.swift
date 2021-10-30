//
//  ProfileSettingCell.swift
//  Minning
//
//  Created by denny on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ProfileSettingCell: UITableViewCell {
    static let identifier: String = "ProfileSettingCell"
    
    private let profileImageView: UIImageView = {
        $0.backgroundColor = .primaryWhite
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    private let cameraButton: UIButton = {
        $0.backgroundColor = .primaryWhite
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    private let nicknameLabel: UILabel = {
        $0.text = "미닝조아 님"
        $0.font = .font16P
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        backgroundColor = .minningLightGray100
        
        [profileImageView, cameraButton, nicknameLabel].forEach {
            contentView.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing).offset(8)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-1)
            make.width.height.equalTo(30)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
