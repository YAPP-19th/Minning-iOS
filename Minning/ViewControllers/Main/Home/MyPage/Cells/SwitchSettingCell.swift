//
//  SwitchSettingCell.swift
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

final class SwitchSettingCell: UITableViewCell {
    static let identifier: String = "SwitchSettingCell"
    
    public var rowItem: MyPageSettingRowItem? {
        didSet {
            titleLabel.text = rowItem?.title
        }
    }
    
    private let titleLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let switchButton: UISwitch = {
        return $0
    }(UISwitch())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLayout() {
        contentView.addSubview(switchButton)
        contentView.addSubview(titleLabel)
        
        switchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(switchButton.snp.leading)
        }
    }
}
