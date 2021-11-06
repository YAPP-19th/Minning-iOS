//
//  NoticeItemCell.swift
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

final class NoticeItemCell: UITableViewCell {
    static let identifier: String = "NoticeItemCell"
    
    private let titleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.font = .font12PMedium
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    
    private let separator: UIView = {
        $0.backgroundColor = .grayEDEDED
        return $0
    }(UIView())
    
    var isRead: Bool = false {
        didSet {
            titleLabel.textColor = isRead ? .primaryBlack : .minningGray100
            descriptionLabel.textColor = isRead ? .minningDarkGray100 : .minningGray100
            dateLabel.textColor = isRead ? .minningDarkGray100 : .minningGray100
        }
    }
    
    var item: NotificationModel? {
        didSet {
            titleLabel.text = item?.title
            descriptionLabel.text = item?.description
            dateLabel.text = item?.date.convertToSmallKoreanString()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        [titleLabel, descriptionLabel, dateLabel, separator].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(separator.snp.top).offset(-15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-17)
        }
    }
}
