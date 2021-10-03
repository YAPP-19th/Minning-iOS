//
//  MyRoutineContentCell.swift
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

final class MyRoutineContentCell: UITableViewCell {
    static let identifier: String = "MyRoutineContentCell"
    
    public var weeklyRoutineData: [Routine] = [] {
        didSet {
            for (index, itemView) in itemViewList.enumerated() {
                itemView.routineItem = weeklyRoutineData.count > index ? weeklyRoutineData[index] : nil
            }
            itemTitleLabel.text = weeklyRoutineData.first?.title
        }
    }
    
    private let itemTitleLabel: UILabel = {
        $0.font = .font14PMedium
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let itemStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 6
        return $0
    }(UIStackView())
    
    private let itemViewList: [MyRoutineContentItemView] = [
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView()
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentViewLayout() {
        contentView.addSubview(itemTitleLabel)
        contentView.addSubview(itemStackView)
        
        for itemView in itemViewList {
            itemStackView.addArrangedSubview(itemView)
        }
        
        itemStackView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
        }
        
        itemTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(itemStackView.snp.leading).offset(-23)
            make.centerY.equalToSuperview()
        }
    }
}
