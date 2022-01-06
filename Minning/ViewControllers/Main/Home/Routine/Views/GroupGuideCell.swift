//
//  GroupGuideCell.swift
//  Minning
//
//  Created by 고세림 on 2021/11/06.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupGuideCell: UITableViewCell {
    static let identifier = "GroupGuideCell"

    private let titleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .minningDarkGray100
        let targetString = "1개"
        let fullText = "\(targetString)의 그룹 인증 사진을 찍었어요!"
        
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font16PBold,
                                       .foregroundColor: UIColor.minningBlue100], range: range)
        $0.attributedText = valueAttrString
        return $0
    }(UILabel())
    
    private let countLabel: UILabel = {
        $0.text = "01/03"
        $0.font = .font14PBold
        $0.textColor = .blue67A4FF
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(missionCount: Int, successedMissionCount: Int) {
        countLabel.text = "\(successedMissionCount)/\(missionCount)"
        
        let targetString = "\(successedMissionCount)개"
        let fullText = "\(targetString)의 그룹 인증 사진을 찍었어요!"
        let range = (fullText as NSString).range(of: targetString)
        let valueAttrString = NSMutableAttributedString(string: fullText)
        valueAttrString.addAttributes([.font: UIFont.font16PBold,
                                       .foregroundColor: UIColor.minningBlue100], range: range)
        titleLabel.attributedText = valueAttrString
    }
    
    private func setupViewLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .minningBlue20
        contentView.layer.cornerRadius = 10

        [titleLabel, countLabel].forEach {
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-8)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
        }
    }
}
