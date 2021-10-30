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
        return $0
    }(UIImageView())
    
    private let cameraButton: UIButton = {
        return $0
    }(UIButton())

    private let nicknameLabel: UILabel = {
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
