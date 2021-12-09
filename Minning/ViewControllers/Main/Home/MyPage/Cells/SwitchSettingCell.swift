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

protocol SwitchSettingCellDelegate: AnyObject {
    func onClickSwitch()
}

final class SwitchSettingCell: UITableViewCell {
    static let identifier: String = "SwitchSettingCell"
    
    public var rowItem: MyPageSettingRowItem? {
        didSet {
            titleLabel.text = rowItem?.title
        }
    }
    
    public weak var delegate: SwitchSettingCellDelegate?
    
    public var isSwitchOn: Bool = false {
        didSet {
            switchButton.setOn(isSwitchOn, animated: true)
        }
    }
    
    private let titleLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let switchButton: UISwitch = {
        $0.addTarget(self, action: #selector(onTapSwitch(_:)), for: .valueChanged)
        return $0
    }(UISwitch())
    
    private let separator: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    @objc
    private func onTapSwitch(_ sender: UISwitch) {
        delegate?.onClickSwitch()
    }
    
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
        contentView.addSubview(separator)
        
        switchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(switchButton.snp.leading)
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
